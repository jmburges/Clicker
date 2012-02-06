$("#startdate").html("<b>Start Date</b> <%=@question.startdate%><br />")
$("#enddate").html("<b>End Date</b> <%=@question.enddate%>")
$("#open_question").countdown
    date: <%=@question.enddate.to_i*1000 %>
    htmlTemplate: "%h:%i:%s"
    leadingZero: false
