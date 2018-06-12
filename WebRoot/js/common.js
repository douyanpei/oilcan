function LTrim(str) {
	var i;
	for (i = 0; i < str.length; i++) {
		if (str.charAt(i) != " ")
			break;
	}
	str = str.substring(i, str.length);
	return str;
}



function getMax(arr){
      //  var arr = [1,56,23,6,43,87,3333,5,555,187];
        var j = arr[0];
        for (var i=1;i<arr.length ;i++ ){
  
            if(arr[i]>j){
                j = arr[i];
            }
        }

        return j;
    
}
function getMin(arr){

      //  var arr = [1,56,23,6,43,87,3333,5,555,187];
        var j = arr[0];
        for (var i=1;i<arr.length ;i++ ){
  
            if(arr[i]<j){
                j = arr[i];
            }
        }

        return j;
    
}
function getAvg(arr){

      //  var arr = [1,56,23,6,43,87,3333,5,555,187];
        var j = 0;
        for (var i=0;i<arr.length ;i++ ){
  				
                j += parseInt(arr[i]);
           
        }

        return Math.ceil(j/arr.length);
    
}
function RTrim(str) {
	var i;
	for (i = str.length - 1; i >= 0; i--) {
		if (str.charAt(i) != " " && str.charAt(i) != " ")
			break;
	}
	str = str.substring(0, i + 1);
	return str;
}

function Trim(str) {
	return LTrim(RTrim(str));
}

function isEmpty(data){  
	return (data == null || data == "" || data == undefined);
}

function numberFormat(form, names){
	form.attachEvent("onInputChange", function (name, value){
		for(var i=0; i<names.length; i++){
			if(name == names[i]){
			    var reg = new RegExp("^[0-9]*$");
			    var temp = "";
        		for(var j=0;j<value.length;j++){
        			if(reg.test(value[j]))
        				temp += value[j];
        		}
        		form.setItemValue(name, temp);
		    }
		}
	});
}

function decimalFormat(form, names){
	form.attachEvent("onInputChange", function (name, value){
		for(var i=0; i<names.length; i++){
			if(name == names[i]){
			    var reg = new RegExp("^[0-9.]*$");
			    var temp = "";
        		for(var j=0;j<value.length;j++){
        			if(reg.test(value[j]))
        				temp += value[j];
        		}
        		form.setItemValue(name, temp);
		    }
		}
	});
}

// 替换数组元素
function replaceArrayElement(array, oldValue, newValue){
	for(var i=0; i<array.length; i++){
		if(array[i] == oldValue)
			array.splice(i, 1, newValue);
	}
}

// 删除数组元素
function deleteArrayElement(array, element){
	for(var i=0; i<array.length; i++){
		if(array[i] == element)
			array.splice(i, 1);
	}
}

// 判断是否重复数组元素
function isSameArrayElement(array, element){
	for(var i=0; i<array.length; i++){
		if(array[i] == element)	
		return true;
	}
	return false;
}

function unique(arr) {
  var result = [], hash = {};
    for (var i = 0, elem; (elem = arr[i]) != null; i++) {
        if (!hash[elem]) {
        	if(!isEmpty(elem)){
	            result.push(elem);
	            hash[elem] = true;
        		
        	}
        }
    }
    
    return result;
}



function isEmptyStr(data){  
		if(isEmpty(data)){
			return "";
		}
		return Trim(data);
}

function isEmptyNull(data){  
		if(isEmpty(data)){
			return null;
		}
		return Trim(data);
}

// 获取treeGrid根id
function getGridFirstIds(grid){
	var ids = "";
	grid.forEachRow(function(id){
		if(grid.getLevel(id)==0)
			ids += "," + id;
	});
	if(ids.length > 0) ids = ids.substring(1);
	return ids;
}

// 获取treeGrid子节点
function getGridChildIds(grid){
	var ids = "";
	grid.forEachRow(function(id){
		if(grid.getLevel(id) == 1)
			ids += "," + id;
	});
	if(ids.length > 0) ids = ids.substring(1);
	return ids;
}

// 获取treeGrid别选中的id
function getGridSelectIds(grid){
	var ids = grid.getSelectedRowId();
	var selectIds = "";
	for(var i=0; i<ids.split(",").length; i++){
		if(grid.getLevel(ids.split(",")[i])==0)
			selectIds += "," + ids.split(",")[i];
	}
	if(selectIds.length>0)
		selectIds = selectIds.substring(1);
	return selectIds;
}

// 获取treeGrid根的id数组
function getIdArray(grid){
	return getGridFirstIds(grid).split(",");
}

function illegalCharacterFilter(value){
    return value.replace(new RegExp("[,、]","gm"),"");
}

function checkGridBySelectRows(grid,nId){
	
	
	grid.attachEvent("onRowSelect", function(id,ind){  

			if(grid.cells(id,nId).getValue() == 0){
    			
           		grid.cells(id,nId).setValue(1);
           	}else{
           		grid.cells(id,nId).setValue(0);
           	}
           	
	});  
	
}

 function checkIndexOf(obj,objs){
	if(isEmpty(objs)){
		return false;
	}
	
	if(objs.indexOf(obj) != -1){
		
		return true;
	}else{
		
		return false;
	}
	
}

 function getExamTypeName(examType){
	if('0'==examType){
		return "职业体检";
	}else if('1'==examType){
		return "从业体检";
	}else if('2'==examType){
		return "健康体检";
	}else if('3'==examType){
		return "放射";
	}else{
		return examType;
	}
 }

  function getGenderStr(gender){
	if('001'==gender){
		return "男";
	}else if('002'==gender){
		return "女";
	}else if('003'==gender){
		return "不限";
	}
	return gender;
 }
 
  function getMaritalStatusStr(status){
	if('001'==status){
		return "已婚";
	}else if('002'==status){
		return "未婚";
	}
	return status;
  }
  
 