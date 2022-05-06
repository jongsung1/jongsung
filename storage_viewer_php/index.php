<title>로그인</title>
<meta charset="UTF-8">
<style type="text/css">
  body,select,option,button{font-size:16px}
  input{border:1px solid #999;font-size:14px;padding:5px 10px}
  input,button{vertical-align:middle}
  form{width:320px;margin:auto}
  span{font-size:14px;color:#f00}
  legend{font-size:20px;text-align:center}
  p span{display:block;margin-left:90px}
  button{cursor:pointer}
  .txt{display:inline-block;width:80px}
  .btn{background:#fff;border:1px solid #999;font-size:14px;padding:4px 10px}
  .btn_wrap{text-align:center}
</style>

<script type="text/javascript">
  function login_check(){
    var USERID = document.getElementById("USERID");
    var PASSWORD = document.getElementById("PASSWORD");

    if(USERID.value == ""){
      var err_txt = document.querySelector(".err_id");
      err_txt.textContent = "아이디를 입력하세요.";
      u_id.focus();
      return false;
    };
    var USERID_len = USERID.value.length;
    if( USERID_len < 4 || USERID_len > 12){
      var err_txt = document.querySelector(".err_id");
      err_txt.textContent = "아이디는 4~12글자만 입력할 수 있습니다.";
      USERID.focus();
      return false;
    };

    if(PASSWORD.value == ""){
      var err_txt = document.querySelector(".err_pwd");
      err_txt.textContent = "비밀번호를 입력하세요.";
      PASSWORD.focus();
      return false;
    };
    var PASSWORD_len = PASSWORD.value.length;
    if( PASSWORD_len < 4 || PASSWORD_len > 10){
      var err_txt = document.querySelector(".err_pwd");
      err_txt.textContent = "비밀번호는 4~10글자만 입력할 수 있습니다.";
      PASSWORD.focus();
      return false;
    };
  };
</script>
<div class="logo" align="center"><img src="./../picture/logo.PNG" alt="" border="0" ></div>
</head>
<div id="container" align="center">
<body>
  <form name="login_form" action="login_ok.php" method="post" onsubmit="return login_check()">
    <fieldset>
      <legend>로그인</legend>
      <p>
        <label for="USERID" class="txt">아이디</label>
        <input type="text" name="USERID" id="USERID" class="USERID" autofocus>
        <br>
        <span class="err_id"></span>
      </p>

      <p>
        <label for="PASSWORD" class="txt">비밀번호</label>
        <input type="password" name="PASSWORD" id="PASSWORD" class="PASSWORD">
        <br>
        <span class="err_pwd"></span>
      </p>

      <p class="btn_wrap">
        <button type="button" class="btn" onclick="history.back()">이전으로</button>
        <button type="button" class="btn" ><A HREF="http://10.0.28.20/join.php" >계정등록</A></button>
        <button type="submit" class="btn">로그인</button>
      </p>
    </fieldset>
  </form>
</body>