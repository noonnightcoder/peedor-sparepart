<script>
$(window).bind("load", function() {
    setTimeout(window.location.href='index?sale_type=<?= $sale_type ?>',5000);
    window.print();
    return true;
});
</script>
