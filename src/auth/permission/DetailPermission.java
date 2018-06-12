package auth.permission;

import java.security.BasicPermission;
import java.security.Permission;
import java.util.ArrayList;
import java.util.List;

import javax.management.RuntimeErrorException;

public class DetailPermission extends BasicPermission implements Comparable<DetailPermission> {
	
	private List<PermissionAction> actions = new ArrayList<PermissionAction>();
	
	public List<PermissionAction> getActionList() {
		return actions;
	}

	public DetailPermission(String name) {
		super(name);
	}

	public DetailPermission(String name, String actions) {
		super(name, actions);
		if(actions != null){
			for(String action:actions.split(",")){
				this.actions.add(new PermissionAction(action.trim())); 
			}
		}
	}

	@Override
	public String getActions() {
		StringBuffer sb = new StringBuffer();
		for(PermissionAction p:this.actions){
			sb.append(","+p.getPattern());
		}
		return sb.length()>0?sb.substring(1):"";
	}

	@Override
	public boolean implies(Permission p) {
//		System.out.println(this.getName()+":"+this.getActions());
		if(p != null && p instanceof DetailPermission){
			DetailPermission ap = (DetailPermission)p;
			return super.implies(p) && this.actions.containsAll(ap.getActionList());
		}
		return false;
	}

	@Override
	public String toString() {
		return this.getClass().getName().toString()+"["+this.getName()+"]["+this.getActions()+"]";
	}

	@Override
	public int compareTo(DetailPermission o) {
		if(o != null){
			return this.toString().compareTo(o.toString());
		}else{
			return 1;
		}
	}
	
	/**
	 * 将一个权限中的action 合并到本权限中
	 * @param other
	 */
	public void mergerActions(DetailPermission other){
		if(!this.getName().equals(other.getName())){
			throw new RuntimeException("权限name不同，不能合并action");
		}else{
			for(PermissionAction otherPa:other.actions){
				boolean has = false;
				for(PermissionAction thisPa:this.actions){
					if(otherPa.getPattern().equals(thisPa.getPattern())){
						has = true;
						break;
					}
				}
				if(!has){
					this.actions.add(otherPa);
				}
			}
		}
	}
	
}

