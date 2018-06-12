package util;

import java.beans.IntrospectionException;
import java.beans.PropertyDescriptor;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.util.Comparator;
import java.util.LinkedList;
import java.util.List;

import net.sourceforge.pinyin4j.format.exception.BadHanyuPinyinOutputFormatCombination;

public class OrderByComparator implements Comparator {

	private List<OrderByFragment> orderBy = new LinkedList<OrderByFragment>();
	
	public OrderByComparator() {
	}

	public OrderByComparator(String orderBy) {
		if (orderBy==null || orderBy.length()==0) {
			return;
		}
		String[] fields = orderBy.split(",");
		for(String field : fields) {
			String[] sections = field.trim().split(" ");
			try {
				this.orderBy.add(new OrderByFragment(sections[0].trim(), sections[1].trim()));
			} catch(ArrayIndexOutOfBoundsException e) {
				this.orderBy.add(new OrderByFragment(sections[0].trim(), "asc"));
			}
		}
	}

	@Override
	public int compare(Object o1, Object o2) {
		int result = 0;
		try {
			if (o1!=null && o1 instanceof Comparable) {
				result = ((Comparable)o1).compareTo(o2);
			} else if (o1==null) {
				throw new NullPointerException();
			} else {
				throw new ClassCastException("Object is not comparable");
			}
		} catch (NullPointerException e) {
			if (o1==null && o2!=null) {
				result = -1;
			} else if (o1!=null && o2==null) {
				result = 1;
			} else if (o1==null && o2==null) {
				result = 0;
			}
		}
		for(OrderByFragment fragment : orderBy) {
			Object propValue1 = null, propValue2 = null;
			String propName = fragment.getPropertyName();
			String order = fragment.getOrder();
			try {
				PropertyDescriptor pd1 = new PropertyDescriptor(propName, o1.getClass());
				propValue1 = pd1.getReadMethod().invoke(o1);
				PropertyDescriptor pd2 = new PropertyDescriptor(propName, o2.getClass());
				propValue2 = pd2.getReadMethod().invoke(o2);
				if (order.equalsIgnoreCase("asc")) {  //正序
					if (propValue1!=null && propValue1 instanceof String) {
						result = Hanyupinyin.toHanyuPinyinWithPadding((String)propValue1).compareTo(Hanyupinyin.toHanyuPinyinWithPadding((String)propValue2));
					} else if (propValue1!=null && propValue1 instanceof Comparable) {
						result = ((Comparable)propValue1).compareTo(propValue2);
					} else if (propValue1==null) {
						throw new NullPointerException();
					} else {
						throw new ClassCastException("Property " + propName + " is not comparable");
					}
				} else if (order.equalsIgnoreCase("desc")) {  //逆序
					if (propValue2!=null && propValue2 instanceof String) {
						result = Hanyupinyin.toHanyuPinyinWithPadding((String)propValue2).compareTo(Hanyupinyin.toHanyuPinyinWithPadding((String)propValue1));
					} else if (propValue2!=null && propValue2 instanceof Comparable) {
						result = ((Comparable)propValue2).compareTo(propValue1);
					} else if(propValue2==null) {
						throw new NullPointerException();
					} else {
						throw new ClassCastException("Property " + propName + " is not comparable");
					}
				} else {  //给定Comparator
					String classname = order.substring(0, order.lastIndexOf("."));
					String fieldname = order.substring(order.lastIndexOf(".") + 1);
					Object obj = Class.forName(classname).newInstance();
					Field field = obj.getClass().getField(fieldname);
					result = ((Comparator)field.get(obj)).compare(o1, o2);
				}
			} catch (IntrospectionException e) {
				result = 0;
			} catch (IllegalArgumentException e) {
				result = 0;
			} catch (IllegalAccessException e) {
				result = 0;
			} catch (InvocationTargetException e) {
				result = 0;
			} catch (InstantiationException e) {
				result = 0;
			} catch (ClassNotFoundException e) {
				result = 0;
			} catch (BadHanyuPinyinOutputFormatCombination e) {
				result = 0;
			} catch (SecurityException e) {
				result = 0;
			} catch (NoSuchFieldException e) {
				result = 0;
			} catch (NullPointerException e) {
				if (o1==null && o2!=null) {
					result = -1;
				} else if (o1!=null && o2==null) {
					result = 1;
				} else if (o1==null && o2==null) {
					result = 0;
				} else {
					if (order.equalsIgnoreCase("asc")) {  //正序
						if (propValue1==null && propValue2!=null) {
							result = -1;
						} else if (propValue1!=null && propValue2==null) {
							result = 1;
						} else if (propValue1==null && propValue2==null) {
							result = 0;
						}
					} else if (order.equalsIgnoreCase("desc")) {  //逆序
						if (propValue1==null && propValue2!=null) {
							result = 1;
						} else if (propValue1!=null && propValue2==null) {
							result = -1;
						} else if (propValue1==null && propValue2==null) {
							result = 0;
						}
					}
				}
			}
			if (result!=0) {
				break;
			}
		}
		return result;
	}

	class OrderByFragment implements java.io.Serializable {
		private static final long serialVersionUID = 6529706523660531879L;
		
		private String propertyName;
		private String order;
		
		public OrderByFragment() {
		}

		public OrderByFragment(String propertyName, String order) {
			this.propertyName = propertyName;
			this.order = order;
		}

		public String getPropertyName() {
			return propertyName;
		}

		public void setPropertyName(String propertyName) {
			this.propertyName = propertyName;
		}

		public String getOrder() {
			return order;
		}

		public void setOrder(String order) {
			this.order = order;
		}

		@Override
		public String toString() {
			StringBuilder builder = new StringBuilder();
			builder.append("OrderByFragment [propertyName=");
			builder.append(propertyName);
			builder.append(", order=");
			builder.append(order);
			builder.append("]");
			return builder.toString();
		}
		
	}
}
