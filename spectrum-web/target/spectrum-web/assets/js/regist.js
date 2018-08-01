$(function () {
    //email的校验
    $("#email").mouseleave(function () {
        var email = $("#email").val()
        //格式校验
        var myreg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
        if(!myreg.test(email))
        {
            $("#error_1").text("格式异常")
        }
        else {
            $("#error_1").text("")
        }

        //长度校验
        if (email.length == 0) {
            $("#error_1").text("邮箱不能为空")
        }

    })

    //password的校验
    $("#password").mouseleave(function () {
        //长度校验
        if ($("#password").val().length == 0) {
            $("#error_2").text("密码不能为空")
        }
    })

    //手机校验
    //由于方法相同，一下只写出相关的正则表达式
    //对于手机号码的验证（提供了两种方法）
    //var mobile=/^((13[0-9]{1})|159|153)+\d{8}$/;
    //var mobile1=/^(13+\d{9})|(159+\d{8})|(153+\d{8})$/;
    //对于区号的验证
    //var phoneAreaNum = /^\d{3,4}$/;
    //对于电话号码的验证
    //var phone =/^\d{7,8}$/;
})