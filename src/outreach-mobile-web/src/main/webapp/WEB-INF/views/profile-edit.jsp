<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page session="false"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Client</title>
        <meta name="viewport" content="initial-scale=1, maximum-scale=1">
        <link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/styles.css">
        <link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/jquery.mobile-1.4.5.min.css">
        <link rel="stylesheet" href="${contextPath}/resources/css/jquery.mobile.datepicker.css">	
        <script src="${contextPath}/resources/js/jquery.js"></script>
        <script src="${contextPath}/resources/js/jquery.mobile-1.4.5.js"></script>    
    </head>

    <body>
        <div data-role="page">
            <script id="mobile-datepicker" src="${contextPath}/resources/js/jquery.mobile.datepicker.js"></script>    
            <script src="${contextPath}/resources/js/jquery.ui.datepicker.js"></script> 
            <script src="${contextPath}/resources/js/lov.js"></script>
            <script>
                <!--    
            $(document).on('pageinit', function ()
                {
                    $(".dateClass").datepicker({
                        yearRange: "1930:2010"
                    });

                    var yearRange = $(".dateClass").datepicker("option", "yearRange");
                    $(".dateClass").datepicker("option", "yearRange", "1930:2010");

                    var changeYear = $(".dateClass").datepicker("option", "changeYear");
                    $(".dateClass").datepicker("option", "changeYear", true);

                    $(".dateClass").datepicker({
                        dateFormat: "yy-mm-dd"
                    });

                    var dateFormat = $(".dateClass").datepicker("option", "dateFormat");
                    // Setter
                    $(".dateClass").datepicker("option", "dateFormat", "yy-mm-dd");

                    $('#save').click(function () {
                        var jsonObj = JSON.stringify($('#profileForm').serializeObject());
                        $.ajax({
                            type: "POST",
                            url: "../service/client",
                            data: jsonObj,
                            dataType: "json",
                            restful: true,
                            contentType: "application/json",
                            cache: false,
                            timeout: 20000,
                            async: true,
                            beforeSend: function (xhr) {
                                //xhr.setRequestHeader('Authorization',bearer);
                            },
                            success: function (data) {
                                $("#successMsg").click();
                                $("#dialog").html("The Client " + data.body[0].firstName + " " +
                                        data.body[0].lastName + " has been created successfully");
                                $('#dialog').fadeOut(500, function () {
                                    $(this).remove();
                                    var enId = data.body[0].id;
                                    window.location.href = "${contextPath}/ui/profile?id=" + enId;
                                });

                            },
                            error: function (data) {
                                $("#successMsg").click();
                                $("#dialog").html("Error while saving the information");
                                $('#dialog').fadeOut(500, function () {
                                    $(this).remove();
                                });
                            }
                        });
                        return false;
                    });

                    $.fn.serializeObject = function ()
                    {
                        var obj = {};
                        var profileFieldArray = this.serializeArray();
                        $.each(profileFieldArray, function () {
                            if (obj[this.name] !== undefined) {
                                if (!obj[this.name].push) {
                                    obj[this.name] = [obj[this.name]];
                                }
                                obj[this.name].push(this.value || '');
                            } else {
                                obj[this.name] = this.value || '';
                            }
                        });
                        return obj;
                    };
                });
-->   
            </script>

            <div data-role="header" class="mheader">
                <a class="iconbar ui-nodisc-icon " href="#menu" data-role="button" 
                   data-theme="c" data-rel="back" data-inline="true" data-icon="bars"> &nbsp; </a>
                <h1>Client</h1>
                <a href="${contextPath}/ui" data-transition="fade"  class="hdright"> 
                    <img src="${contextPath}/resources/img/findicon.jpg"  >
                </a>
            </div>
            <div data-role="panel" id="menu" data-display="push">
                <div class="ui-panel-inner">
                    <h3>Menu</h3>
                    <ul data-role="listview" class="mainMenu">
                        <li> <a href="${contextPath}/ui" data-transition="fade" >
                                <img src="${contextPath}/resources/img/search.png"> Client Search</a></li>
                        <li><a href="${contextPath}/logout" data-transition="fade" >
                                <img src="${contextPath}/resources/img/logout.png"> Logout</a></li>
                    </ul>
                </div>
            </div>
            <div data-role="main" class="ui-content maincontent">
                <div class="cvcard">
                    <div class="cvardid">
                        <div class="cameraicon"><img src="${contextPath}/resources/img/camera.png" width="30" height="25"></div>
                            <c:choose>
                                <c:when test="${not empty clientProfile.imageUrl}">
                                <img src="${clientProfile.imageUrl}" width="243" height="227">
                            </c:when>
                            <c:otherwise>
                                <img src="${contextPath}/resources/img/userimg3.jpg" width="243" height="227">
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="cvarddesc">
                        <div class="editbtn"><img src="${contextPath}/resources/img/edit-dis.png"  ></div>
                        <h4><c:out value="${clientProfile.firstName}"/>&nbsp;</h4>
                        <p><c:out value="${clientProfile.dob}"/></p>
                        <p><c:out value="${clientProfile.id}"/></p>
                        <hr>
                        <p><c:out value="${clientProfile.gender}"/></p>
                        <p><c:out value="${clientProfile.race}"/></p>

                    </div>
                </div>
                <form action="" method="post" id="profileForm">
                    <div class="sresult">
                        <ul class="noborder">
                            <li class="nobg">
                                <div class="clientmenu">
                                    <input type="text" name="PersonalID" id="PersonalID" placeholder="Client ID" disabled="true">
                                </div>
                            </li>
                            <li class="nobg">
                                <div class="clientmenu">
                                    <select name="NameDataQuality" id="NameDataQuality" placeholder="Name Data Quality">
                                        <option value="-1" selected = "selected">Name Data Quality</option>
                                    </select>
                                </div>
                            </li>
                            <li class="nobg">
                                <div class="clientmenu"> 
                                    <input type="text" name="FirstName" id="FirstName" placeholder="First Name">
                                </div>
                            </li>
                            <li class="nobg">
                                <div class="clientmenu">
                                    <input type="text" name="MiddleName" id="MiddleName" placeholder="Middle Name">
                                </div>
                            </li>
                            <li class="nobg">
                                <div class="clientmenu">
                                    <input type="text" name="LastName" id="LastName" placeholder="Last Name">
                                </div>
                            </li>
                            <li class="nobg">
                                <div class="clientmenu"> 
                                    <input type="text" name="NameSuffix" id="NameSuffix" placeholder="Suffix">
                                </div>
                            </li>
                            <li class="nobg">
                                <div class="clientmenu">
                                    <select name="Gender" id="Gender" placeholder="Gender">
                                        <option value="-1" selected = "selected">Gender</option>
                                    </select>
                                    <input type="hidden" name="VeteranStatus" id="VeteranStatus" value ="-1"/>
                                </div>
                            </li>
                            <li class="nobg">
                                <div class="clientmenu">
                                    <select name="SSNDataQuality" id="SSNDataQuality" placeholder="SSN Quality">
                                        <option value="-1" selected = "selected">SSN Quality</option>
                                    </select>
                                </div>
                            </li>
                            <li class="nobg">
                                <div class="clientmenu">             
                                    <input type="text" name="SSN" id="SSN" placeholder="SSN">
                                </div>
                            </li>
                            <li class="nobg">
                                <div class="clientmenu">
                                    <select type="text" name="DOBDataQuality" id="DOBDataQuality" placeholder="DOB Type">
                                        <option value="-1" selected = "selected">DOB Type</option>      
                                    </select>
                                </div>
                            </li>
                            <li class="nobg">
                                <div class="clientmenu">
                                    <input type="text" name="DOB" class="dateClass" data-role="date" id="DOB" 
                                           value='<c:out value="${clientProfile.dob}"/>' placeholder="DOB">
                                </div>
                            </li>
                            <li class="nobg">
                                <div class="clientmenu">
                                    <select type="text" name="Race" id="Race" placeholder="Race">
                                        <option value="-1" selected = "selected">Race</option>    
                                    </select>
                                </div>
                            </li>
                            <li class="nobg">
                                <div class="clientmenu">
                                    <select type="text" name="Ethnicity" id="Ethnicity" placeholder="Ethnicity">
                                        <option value="-1" selected = "selected">Ethnicity</option>
                                    </select>
                                </div>
                            </li>
                        </ul>
                    </div> 
                    <div class="ui-grid-a">
                        <div class="ui-block-a">
                            <a href="profile.html" data-role="button" class="whitebtn mtp20" >Back</a>
                        </div>
                        <div class="ui-block-b">
                            <button type="button" id="save" data-role="button" class="blubtn mtp20" 
                                    data-transition="fade">Save</button> 
                        </div>
                    </div>

                </form>  
                <a id='successMsg' href="#dialog" data-rel="dialog" 
                   data-transition="pop" style='display:none;'></a>
                <div data-role="page" id="dialog"></div>
            </div>


        </div>
    </body>
</html>
