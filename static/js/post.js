document.querySelectorAll('pre code').forEach((block) => {
  hljs.highlightBlock(block);
});
$("pre").attr("style","");
$("pre code").addClass("hljs");
$("span").attr("style","");