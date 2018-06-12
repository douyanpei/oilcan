package auth.permission;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;


public class PermissionRecorder{
	HttpSession session = null;
	Map<String,DetailPermission> map = null;
	
	public Map<String, DetailPermission> getMap() {
		return map;
	}


	public PermissionRecorder(HttpSession session){
		this.session = session;
		this.map = (Map<String,DetailPermission>)this.session.getAttribute(PermissionRecorder.class.toString()+".map");
		if(this.map == null){
			this.map = new HashMap<String,DetailPermission>();
			this.session.setAttribute(PermissionRecorder.class.toString()+".map", this.map);
		}
	}
	
	public void record(DetailPermission p){
		DetailPermission mergerP = this.map.get(p.getClass().toString()+"."+p.getName());
		if(mergerP == null){
			this.map.put(p.getClass().toString()+"."+p.getName(), p);
		}else{
			List<PermissionAction> paList = mergerP.getActionList();
			for(PermissionAction pa:p.getActionList()){
				if(!paList.contains(pa)){
					paList.add(pa);
				}
			}
		}
	}
}
