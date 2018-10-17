/**
 * myScript.js 
 */

function bbsCheck(f){
	var wname = f.wname.value;
	var subject = f.subject.value;
	var content = f.content.value;
	var passwd = f.passwd.value;
	
	wname = wname.trim();
	subject = subject.trim();
	content = content.trim();
	passwd = passwd.trim();
	
	//1) 작성자 글자수 제한
	if(wname.length<2 || wname.length>20){
		alert("이름은 2~20글자 이내로 입력해주세요.");
		f.wname.focus();
		return false;
	}//if end
	
	//2) 제목 글자수 제한
	if(subject.length<2 || subject.length>20){
		alert("제목은 2~20글자 이내로 입력해주세요.");
		f.subject.focus();
		return false;
	}
		
	//3) 내용 글자수 제한
	if(content.length<2 || content.length>1000){
		alert("2~1000글자 이내만 작성 가능합니다..");
		f.subject.focus();
		return false;
	}
		
	//4) 비밀번호는 반드시 4글자만 허용
	if(passwd.length!=4){
		alert("비밀번호는 4자리로만 가능합니다.");
		f.passwd.focus;
		return false;
	}
	
	return true;
} //bbsCheck() end

function pwCheck(f){
	var passwd = f.passwd.value;
	passwd=passwd.trim();
	
	if(passwd.length!=4){
		alert("비밀번호는 4자리로만 가능합니다.");
		f.passwd.focus;
		return false;
	}//end
	
	var mess="진행된 내용은 복구되지 않습니다.\n 계속 진행하시겠습니까?";
	if(confirm(mess)){ //확인 true, 취소 false
		return true;
	}else{
		return false;
	}//end
}//pwCheck() end

function search(f){
	var word = f.word.value;
	word=word.trim();
	if(word.length==0){
		alert("검색어를 입력하세요!");
		f.word.focus();
		return false;
	}else{
		return true;
	}//end
}//search() end

function memberCheck(f){
	//회원가입 유효성 검사
		
	var id = f.id.value;
	var passwd = f.passwd.value;
	var repasswd = f.repasswd.value;
	var mname = f.mname.value;
	var email = f.email.value;
	var job = f.job.value;	
		
	id=id.trim();
	passwd=passwd.trim();
	repasswd=repasswd.trim();
	mname=mname.trim();
	email=email.trim();
	job=job.trim();
	
	//1) 아이디 8~10글자 이내
	if(id.length<8 || id.length>10){
		alert("아이디는 8~10글자로만 작성해주세요");
		return false;
	}
		
	//2) 비밀번호 8~10글자 이내
	if(passwd.length<8 || passwd.length>10){
		alert("비밀번호는 8~10글자로만 작성해주세요");
		return false;
	}
	if(repasswd.length<8 || repasswd.length>10){
		alert("비밀번호확인은 8~10글자로만 작성해주세요");
		return false;
	}
		
	//3) 2개의 비밀번호가 서로 일치하는지 검사	
	if(repasswd!=passwd){
		alert("비밀번호와 비밀번호확인이 일치하지않습니다.");
		return false;
	}
	
	//4) 이름 2~20글자 이내	
	if(mname.length<2 || mname.length>20){
		alert("이름는 2~20글자로만 작성해주세요");
		return false;
	}

	//5) 이메일 검사(@ 있는지 . 있는지)	
	if(email.indexOf("@")==-1 || email.indexOf(".")==-1){
		alert("이메일에 @와 .이 포함되어야합니다.");
		return false;
	}
	
	// 6) 직업선택	
	if(job=="0"){
		alert("직업 선택해 주세요");
		return false;
	}//if end
	
	return true;
	
}//memberCheck() end

function noticeCheck(f){
	var subject = f.subject.value;
	var content = f.content.value;
	
	subject=subject.trim();
	content=content.trim();
	
	if(subject.length<2 || subject.length>20){
		alert("제목은 2~20글자로만 입력가능합니다.");
		return false;
	}
	if(content.length<2 || subject.length>300){
		alert("내용은 2~300글자로만 입력가능합니다.");
		return false;
	}
	return true;
}//noticeCheck() end

function idCheck(){
	//아이디 중복확인
	
	//새창이 출력되는 위치 지정
	var sx=parseInt(screen.width);
	var sy=parseInt(screen.height);
	var x=(sx/2)+50;
	var y=(sy/2)-25;
	
	//새창띄우기
	var win=window.open("idCheckForm.jsp","idwin","width=400,height=350");
	
	//화면이동
	win.moveTo(x,y);	
	
}//idCheck() end

function idCheckdo(){
	//아이디 중복확인
	
	//새창이 출력되는 위치 지정
	var sx=parseInt(screen.width);
	var sy=parseInt(screen.height);
	var x=(sx/2)+50;
	var y=(sy/2)-25;
	
	//새창띄우기
	var win=window.open("./idCheckForm.do","idwin","width=400,height=350");
	
	//화면이동
	win.moveTo(x,y);	
	
}//idCheck() end

function emailCheck(){
	//email 중복확인
	
	//새창이 출력되는 위치 지정
	var sx=parseInt(screen.width);
	var sy=parseInt(screen.height);
	var x=(sx/2)+50;
	var y=(sy/2)-25;
	
	//새창띄우기
	var win=window.open("emailCheckForm.jsp","emailwin","width=400,height=350");
	
	//화면이동
	win.moveTo(x,y);	
}

function emailCheckdo(){
	//email 중복확인
	
	//새창이 출력되는 위치 지정
	var sx=parseInt(screen.width);
	var sy=parseInt(screen.height);
	var x=(sx/2)+50;
	var y=(sy/2)-25;
	
	//새창띄우기
	var win=window.open("emailCheckForm.jsp","emailwin","width=400,height=350");
	
	//화면이동
	win.moveTo(x,y);	
}

function emailCheck2(){
	//email 중복확인
	
	//새창이 출력되는 위치 지정
	var sx=parseInt(screen.width);
	var sy=parseInt(screen.height);
	var x=(sx/2)+50;
	var y=(sy/2)-25;
	
	//새창띄우기
	var win=window.open("./emailCheckForm2.do","emailwin","width=400,height=350");
	
	//화면이동
	win.moveTo(x,y);	
}

function emailCheckdo2(){
	//email 중복확인
	
	//새창이 출력되는 위치 지정
	var sx=parseInt(screen.width);
	var sy=parseInt(screen.height);
	var x=(sx/2)+50;
	var y=(sy/2)-25;
	
	//새창띄우기
	var win=window.open("./emailCheckForm2.do","emailwin","width=400,height=350");
	
	//화면이동
	win.moveTo(x,y);	
}

function loginCheck(f){
	var id = f.id.value;
	var passwd = f.passwd.value;
	
	id=id.trim();
	passwd=passwd.trim();
	//1) 아이디 8~10글자 이내
	if(id.length<8 || id.length>10){
		alert("아이디는 8~10글자 이내로 입력해주세요.");
		f.id.focus();
		return false;
	}
	//2) 비밀번호 8~10글자 이내
	if(passwd.length<8 || passwd.length>10){
		alert("비밀번호는 8~10글자 이내로 입력해주세요.");
		f.passwd.focus();
		return false;
	}
	return true;
}

function idpwSearch(f){
	//아이디, 비밀번호 찾기
	var mname = f.mname.value;
	var email = f.email.value;
	
	mname=mname.trim();
	email=email.trim();
	//1) 이름 2~20글자 이내
	if(mname.length<2 || mname.length>20){
		alert("이름는 2~20글자로만 작성해주세요");
		return false;
	}

	//2) 이메일 검사(@ 있는지 . 있는지)	
	if(email.indexOf("@")==-1 || email.indexOf(".")==-1){
		alert("이메일에 @와 .이 포함되어야합니다.");
		return false;
	}	
}//idpwSearch() end

function checkData(f){
	//포토갤러리 게시판 유효성검사
	var wname = f.wname.value;
	var subject = f.subject.value;
	var passwd = f.passwd.value;
	var filename = f.filename.value;	
	
	wname=wname.trim();	
	subject=subject.trim();	
	passwd=passwd.trim();	
	filename = filename.trim();
	
	//1) 이름	
	if(wname.length<2 || wname.length>10){
		alert("이름은 2~10글자로 작성해주세요")
		return false;
	}
	//2) 제목	
	if(subject.length<2 || subject.length>20){
		alert("제목은 2~20글자로 작성해주세요")
		return false;
	}
	//3) 비밀번호
	if(passwd.length<8 || passwd.length>10){
		alert("비밀번호는 8~10글자로 작성해주세요")
		return false;
	}
	//4) 첨부파일 
	if(filename.length<5){  //확장명 4글자
		alert("첨부파일을 선택하세요");
		return false;
	}
	//5) .png .gif .jpg .bmp 만 업로드 가능
	var ext = filename.toLowerCase(); //파일명을 전부 소문자로
	if(!(ext.lastIndexOf('.png')>0 || ext.lastIndexOf('.gif')>0 || ext.lastIndexOf('.jpg')>0 || ext.lastIndexOf('.bmp')>0)){
		alert("이미지파일만 업로드 가능합니다.");
	}
	
	return true;
}//checkData() end

function pwCheck2(f){
	var passwd = f.passwd.value;
	passwd=passwd.trim();
	
	if(passwd.length<8 || passwd.length>10){
		alert("비밀번호는 8~10자리로 입력해주세요.");
		f.passwd.focus;
		return false;
	}//end
	
	var mess="진행된 내용은 복구되지 않습니다.\n 계속 진행하시겠습니까?";
	if(confirm(mess)){ //확인 true, 취소 false
		return true;
	}else{
		return false;
	}//end
}//pwCheck() end

function checkData2(f){
	//포토갤러리 게시판 유효성검사
	var wname = f.wname.value;
	var subject = f.subject.value;
	var passwd = f.passwd.value;
	var filename = f.filename.value;	
	
	wname=wname.trim();	
	subject=subject.trim();	
	passwd=passwd.trim();	
	filename = filename.trim();
	
	//1) 이름	
	if(wname.length<2 || wname.length>10){
		alert("이름은 2~10글자로 작성해주세요")
		return false;
	}
	//2) 제목	
	if(subject.length<2 || subject.length>20){
		alert("제목은 2~20글자로 작성해주세요")
		return false;
	}
	//3) 비밀번호
	if(passwd.length<8 || passwd.length>10){
		alert("비밀번호는 8~10글자로 작성해주세요")
		return false;
	}
	
	return true;
}//checkData() end





