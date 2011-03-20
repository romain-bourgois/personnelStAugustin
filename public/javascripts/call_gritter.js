<%- flash.each do |name, msg| -%>
  $.gritter.add({
   title: 'titre',
   text: "<%= msg %>"
  });
<%- end -%>