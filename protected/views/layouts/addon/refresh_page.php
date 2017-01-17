<script>
(function worker() {
    $.ajax({
        url: '<?=  Yii::app()->createUrl('RefreshPage/index'); ?>',
        success: function(data) {
            $('#logout_link').html(data);
        },
        complete: function() {
            // Schedule the next request when the current one's complete
            setTimeout(worker, 50000);
        }
    });
})();
</script>