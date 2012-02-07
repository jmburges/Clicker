$("#enddate").html("<b>End Date</b> <%=@question.enddate%>")
$("#question_partial").html("<%=escape_javascript(render :partial =>"closed_question")%>")
