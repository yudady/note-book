# ajaxSubmit

> jQuery Form Plugin version: 3.51.0-2014.06.20
Requires jQuery v1.5 or later
Copyright (c) 2014 M. Alsup
Examples and documentation at: http://malsup.com/jquery/form/
Project repository: https://github.com/malsup/form
Dual licensed under the MIT and GPL licenses.
https://github.com/malsup/form#copyright-and-license


## form ajax submit可以上传文件
> let data = $("#form").fieldSerialize();
```
<form id="myForm" action="comment.php" method="post"> 
    Name: <input type="text" name="name" /> 
    Comment: <textarea name="comment"></textarea> 
    <input type="submit" value="Submit Comment" /> 
</form>


$("#activityPicturesForm").validate({
    rules: {
        openNewUrl: {
            required: true,
            cusUrl: true
        }
    },
    submitHandler: function () {

        return false;
    }
});

```
 