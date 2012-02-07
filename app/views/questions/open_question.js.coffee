$("#startdate").html("<b>Start Date</b> <%=@question.startdate%><br />")
$("#enddate").html("<b>End Date</b> <%=@question.enddate%>")
$("#question_partial").html("<%=escape_javascript(render :partial =>"open_question")%>")
