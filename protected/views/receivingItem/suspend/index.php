<?php
$this->breadcrumbs = array(
    'Transaction',
    //Common::saleTitle() => array('index?sale_type=' . Common::getSaleType()),
    'Suspended Transaction',
);
?>

<?php $this->renderPartial('suspend/partial/search', array(
    'model' => $model,
));
?>


<div id="suspend_grid">

<?php $this->renderPartial('suspend/partial/suspend_sale', array(
        'model' => $model,
)); ?>

</div>

<script>
    jQuery( function($){
        $('div#suspend_header').on('click','.btn-view',function(e) {
            e.preventDefault();
            var data=$("#suspend-form").serialize();
            $.ajax({url: '<?=  Yii::app()->createUrl($this->route); ?>',
                type : 'GET',
                data : data,
                beforeSend: function() { $('.waiting').show(); },
                complete: function() { $('.waiting').hide(); },
                success : function(data) {
                    //$("#suspend_grid").html(data.div); // Using with Json Data Return
                    $("#suspend_grid").html(data);
                    //console.log(data);
                    return false;
                }
            });
        });
    });
</script>
