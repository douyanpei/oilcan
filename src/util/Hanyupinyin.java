package util;

import java.util.Comparator;

import net.sourceforge.pinyin4j.PinyinHelper;
import net.sourceforge.pinyin4j.format.HanyuPinyinCaseType;
import net.sourceforge.pinyin4j.format.HanyuPinyinOutputFormat;
import net.sourceforge.pinyin4j.format.HanyuPinyinToneType;
import net.sourceforge.pinyin4j.format.HanyuPinyinVCharType;
import net.sourceforge.pinyin4j.format.exception.BadHanyuPinyinOutputFormatCombination;

public class Hanyupinyin {
	
	private static final int LONGEST_HANYUPINYIN_LENGTH = 6;	// zhuang
	
	public static final Comparator<String> HANYUPINYIN_ORDER = new Comparator<String>() {
		@Override
		public int compare(String o1, String o2) {
			try {
				String pinyin1 = toHanyuPinyinWithPadding(o1);
				String pinyin2 = toHanyuPinyinWithPadding(o2);
				return pinyin1.compareToIgnoreCase(pinyin2);
			} catch(BadHanyuPinyinOutputFormatCombination e) {
				return 0;
			}
		}
	    
	};
	
	/**
	 * 汉字转换位汉语拼音首字母，英文字符和不变
	 * 
	 * @param chinese 汉字
	 * @return 拼音首字母
	 * @throws BadHanyuPinyinOutputFormatCombination
	 */
	public static String toHanyuPinyinCapital(String chinese) throws BadHanyuPinyinOutputFormatCombination {
		if (chinese==null || chinese.length()==0)
			return "";
		String pinyinName = "";
		char[] nameChar = chinese.replaceAll("\\s+", "").toCharArray();
		for (int i = 0; i < nameChar.length; i++) {
			String[] pinyin =  PinyinHelper.toHanyuPinyinStringArray(nameChar[i], getDefaultOutputFormat());
			if (pinyin!=null)  //是汉字
				pinyinName += pinyin[0].charAt(0);
			else  //不是汉字
				pinyinName += nameChar[i];
		}
		return pinyinName;
	}

	/**
	 * 汉字转换为汉语拼音，英文字符不变
	 * 
	 * @param chinese 汉字
	 * @return 拼音
	 * @throws BadHanyuPinyinOutputFormatCombination
	 */
	public static String toHanyuPinyinWithPadding(String chinese) throws BadHanyuPinyinOutputFormatCombination {
		if (chinese==null || chinese.length()==0)
			return "";
		String pinyinName = "";
		char[] nameChar = chinese.replaceAll("\\s+", "").toCharArray();
		for (int i = 0; i < nameChar.length; i++) {
			String[] pinyin =  PinyinHelper.toHanyuPinyinStringArray(nameChar[i], getDefaultOutputFormat());
			if (pinyin!=null)  //是汉字
				pinyinName += padding(pinyin[0]);
			else  //不是汉字
				pinyinName += nameChar[i];
		}
		return pinyinName;
	}

	private static String padding(String hanyupinyin) {
		char[] dest = new char[LONGEST_HANYUPINYIN_LENGTH];
		for(int i=0; i<dest.length; i++)
			dest[i] = ' ';
		char[] src = hanyupinyin.toCharArray();
		System.arraycopy(src, 0, dest, 0, src.length);
		return String.copyValueOf(dest);
	}
	
	public static String toHanyuPinyinWithoutPadding(String chinese) throws BadHanyuPinyinOutputFormatCombination {
		if (chinese==null || chinese.length()==0)
			return "";
		String pinyinName = "";
		char[] nameChar = chinese.replaceAll("\\s+", "").toCharArray();
		for (int i = 0; i < nameChar.length; i++) {
			String[] pinyin =  PinyinHelper.toHanyuPinyinStringArray(nameChar[i], getDefaultOutputFormat());
			if (pinyin!=null)  //是汉字
				pinyinName += pinyin[0];
			else  //不是汉字
				pinyinName += nameChar[i];
		}
		return pinyinName;
	}

	private static HanyuPinyinOutputFormat getDefaultOutputFormat() {
		HanyuPinyinOutputFormat format = new HanyuPinyinOutputFormat();
		format.setCaseType(HanyuPinyinCaseType.LOWERCASE); // 小写
		format.setToneType(HanyuPinyinToneType.WITHOUT_TONE); // 没有音调数字
		format.setVCharType(HanyuPinyinVCharType.WITH_V); // 显示v
		return format;
	}
	
}
