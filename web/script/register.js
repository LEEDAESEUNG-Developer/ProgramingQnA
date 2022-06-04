document.addEventListener("DOMContentLoaded", function () {

    let form = document.register;
    console.log(form);

    // 닉네임 중복체크 버튼
    let btn_confirmWriter = document.getElementById("confirmWriter");
    btn_confirmWriter.addEventListener("click", function () {
        if(form.writer.value == ""){
            alert("닉네임을 입력해주세요");
            form.writer.focus();
            return;
        } else {
            location = '../login/checkWriterPro.jsp?writer=' + form.writer.value;
        }
    });

    // 아이디 중복체크 버튼
    let btn_confirmId = document.getElementById("confirmId");
    btn_confirmId.addEventListener("click", function () {
        if(form.id.value == ""){
            alert("아이디를 입력해주세요");
            form.id.focus();
            return;
        } else {
            location = '../login/checkIdPro.jsp?id=' + form.id.value;
        }
    });



});
