<?php $box = $this->beginWidget('yiiwheels.widgets.box.WhBox',array(
        'title'         =>  Yii::t('app',$trans_header),
        'headerIcon'    => 'ace-icon fa fa-cloud-download',
        'htmlHeaderOptions'=>array('class'=>'widget-header-flat widget-header-small'),
        'headerButtons' => array(
            TbHtml::buttonGroup(
                array(
                    array('label' => Yii::t('app','On-going Transaction '),'url' =>Yii::app()->createUrl('ReceivingItem/ListSuspendedSale/'),'icon'=>'ace-icon fa fa-spinner fa-spin white'),
                    array('label'=>' | '),
                    array('label' => Yii::t('app','New Item'),'url' =>Yii::app()->createUrl('Item/createImage',array('grid_cart'=>'R')),'icon'=>'glyphicon-plus white'),
                ),array('color'=>TbHtml::BUTTON_COLOR_PRIMARY,'size'=>TbHtml::BUTTON_SIZE_SMALL)
            ),
        )
));
?>
<div id="itemlookup">
    <?php $form=$this->beginWidget('bootstrap.widgets.TbActiveForm',array(
            'action'=>Yii::app()->createUrl('receivingItem/add'),
            'method'=>'post',
            'layout'=>TbHtml::FORM_LAYOUT_HORIZONTAL,
            'id'=>'add_item_form',
    )); ?> 

        <?php 
        $this->widget('zii.widgets.jui.CJuiAutoComplete', array(
                'model'=>$model,
                'attribute'=>'item_id',
                'source'=>$this->createUrl('request/suggestItem'),
                'htmlOptions'=>array(
                    'size'=>'40'
                ),
                'options'=>array(
                    'showAnim'=>'fold',
                    'minLength'=>'1',
                    'delay' => 10,
                    'autoFocus'=> false,
                    'select'=>'js:function(event, ui) {
                        event.preventDefault();
                        $("#ReceivingItem_item_id").val(ui.item.id);
                        $("#add_item_form").ajaxSubmit({target: "#register_container", beforeSubmit: receivingsBeforeSubmit, success: itemScannedSuccess(ui.item.id)});
                    }',
                ),
            ));
        ?>

    <?php $this->endWidget(); ?>
</div>

<?php $this->endWidget(); ?>

<?php Yii::app()->clientScript->registerScript('setFocus', '$("#ReceivingItem_item_id").focus();'); ?>
 
<?php 
    Yii::app()->clientScript->registerScript( 'deleteItem', "
        jQuery( function($){
            $('div#grid_cart').on('click','a.delete-item',function(e) {
                e.preventDefault();
                var url=$(this).attr('href');
                $.ajax({url:url,
                        type : 'post',
                        beforeSend: function() { $('.waiting').show(); },
                        complete: function() { $('.waiting').hide(); },
                        success : function(data) {
                            $('#register_container').html(data);
                          }
                    });
                });
        });
      ");
 ?>

<?php
Yii::app()->clientScript->registerScript( 'setComment', "
        jQuery( function($){
            $('#comment_content').on('change','#comment_id',function(e) {
                e.preventDefault();
                var comment=$(this).val();
                $.ajax({
                        url: 'SetComment',
                        dataType : 'json',
                        data : {comment : comment},
                        type : 'post',
                        beforeSend: function() { $('.waiting').show(); },
                        complete: function() { $('.waiting').hide(); },
                        success : function(data) {
                                if (data.status==='success')
                                {
                                    console.log('comment saved');

                                }
                                else
                                {
                                    alert('someting wrong');
                                    return false;
                                }
                       }
                 });
            });
        });
      ");
?>

<script title="text/javascript" language="JavaScript">

var submitting = false;

$(document).ready(function()
{
    //Here just in case the loader doesn't go away for some reason
    $('.waiting').hide();

    // ajaxForm to ensure is submitting as Ajax even user press enter key
    $('#add_item_form').ajaxForm({target: "#register_container", beforeSubmit: receivingsBeforeSubmit, success: itemScannedSuccess});

    $('.line_item_form').ajaxForm({target: "#register_container", beforeSubmit: receivingsBeforeSubmit });

    $('#total_discount_form').ajaxForm({target: "#register_container", beforeSubmit: receivingsBeforeSubmit});

    $('#cart_contents').on('change','input.input-grid',function(e) {
        e.preventDefault();
        $(this.form).ajaxSubmit({target: "#register_container", beforeSubmit: receivingsBeforeSubmit });
    });

    $('#cancel_cart').on('click','#cancel_receiving_button',function(e) {
      e.preventDefault();
      if (confirm("<?php echo Yii::t('app','Are you sure you want to clear this receiving? All items will cleared.'); ?>")){
            $('#cancel_recv_form').ajaxSubmit({target: "#register_container", beforeSubmit: receivingsBeforeSubmit});
        }
    });

    $('#supplier_cart').on('click','a.detach-supplier', function(e) {
        e.preventDefault();
        $('#supplier_selected_form').ajaxSubmit({target: "#register_container", beforeSubmit: receivingsBeforeSubmit});
    });

    $('#total_discount_cart').on('change','input.input-totaldiscout',function(e) {
        e.preventDefault();
        $(this.form).ajaxSubmit({target: "#register_container", beforeSubmit: receivingsBeforeSubmit });
    });

    $('.input-mask-date').mask('99/99/9999');

    <?php if(!empty($items)) { ?>
    $("#sidebar a").unbind().click(function(e) {
        e.preventDefault();
        a_href = $(this).attr("href");
        $.confirm({
            title: 'Confirm!',
            content: 'Your process will be suspend if you leave this current page, Are you sure?',
            columnClass: 'col-md-6 col-md-offset-3',
            buttons: {
                confirm: {
                    btnClass: 'btn-success',
                    action: function(){
                        $.ajax({
                            type: "POST",
                            url: "/ReceivingItem/SuspendRecv/",
                            success: function () {
                                window.location.href = a_href;
                            }
                        });
                    }
                },
                cancel: function () {
                },
            }
        });
    });
    <?php } ?>

});

function receivingsBeforeSubmit(formData, jqForm, options)
{
    if (submitting)
    {
        return false;
    }
    submitting = true;
    $('.waiting').show();
}

function itemScannedSuccess(itemId)
{
    return function (responseText, statusText, xhr, $form ) {
        setTimeout(function(){$('#quantity_' + itemId).select();}, 10);
    }
}


/*function itemScannedSuccess(responseText, statusText, xhr, $form)
{
    setTimeout(function(){$('#ReceivingItem_item_id').focus();}, 10);
}*/

/*$("#sidebar a").on('click', function (e){
    e.preventDefault();
    var curr_link = window.location.href;
    var host = window.location.origin;
    var clicked_link = host+$(this).attr("href");
    var url="/ReceivingItem/SuspendRecv/";

    if(curr_link!=clicked_link)
    {
        //var answer=confirm('Your process will be suspend if you leave this current page, Are you sure?');
        if(confirm('Your process will be suspend if you leave this current page, Are you sure?'))
        {
            $.ajax({
                url: url,
                type: 'POST',
                success: function(data) {
                    location.href = clicked_link;
                }
            });
        }
    }
});*/


    /*$(window).on("beforeunload", function(e) {
        return function(){
            var url="/ReceivingItem/SuspendRecv/";
            $.ajax({
                url: url,
                type: 'POST',
                success: function(data) {
                    location.href = $(this).attr("href");
                }
            });
        };
    });*/

    /*$(window).bind('beforeunload', function () {
        //this will work only for Chrome
        //saveFormData();
        return "kdfkd";
    });*/

    /*$(window).bind("unload", function () {
        //this will work for other browsers
        saveFormData();
    });*/

    /*function saveFormData(){
        $.ajax({
            type: 'POST',
            async: false,
            url: '/ReceivingItem/SuspendRecv/'
        });
    }*/
    /*$("#sidebar a").on('click', function (e) {
        //check form to make sure it is kosher
        //remove the ev
        //$(window).off("beforeunload");
        //return true;
    });*/
</script>