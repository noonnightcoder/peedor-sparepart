<?php Yii::app()->clientScript->registerScript('setFocus', '$("#SaleItem_item_id").focus();'); ?>

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
Yii::app()->clientScript->registerScript( 'addPayment', "
        jQuery( function($){
            $('#payment_cart').on('click','a.add-payment',function(e) {
                e.preventDefault();
                var url=$(this).attr('href');
                var message=$('.message');
                var payment_id=$('#payment_type_id').val();
                var payment_amount=$('#payment_amount_id').val();
                var alt_payment_amount=$('#alt_payment_amount_id').val();
                $.ajax({url:url,
                        type : 'post',
                        beforeSend: function() { $('.waiting').show(); },
                        complete: function() { $('.waiting').hide(); },
                        data : {payment_id : payment_id, payment_amount : payment_amount, alt_payment_amount : alt_payment_amount},
                        success : function(data) {
                              $('#register_container').html(data);
                              $('#finish_sale_button').focus();
                          }
                    });
                });
        });
      ");
?>

<?php
Yii::app()->clientScript->registerScript( 'enterPayment', "
        jQuery( function($){
            $('#payment_cart').on('keypress','.payment-amount-txt',function(e) {
                if (e.keyCode === 13 || e.which === 13)
                {
                    e.preventDefault();
                    var url=$(this).data('url');
                    var message=$('.message');
                    var payment_id=$('#payment_type_id').val();
                    var payment_amount=$('#payment_amount_id').val();
                    var alt_payment_amount=$('#alt_payment_amount_id').val();
                    $.ajax({url:url,
                            type : 'post',
                            beforeSend: function() { $('.waiting').show(); },
                            complete: function() { $('.waiting').hide(); },
                            data : {payment_id : payment_id, payment_amount : payment_amount, alt_payment_amount : alt_payment_amount},
                            success : function(data) {
                                  $('#register_container').html(data);
                                  $('#finish_sale_button').focus();
                             }
                      }); // end ajax
                      //return false;
                  } // end if
             });
        });
      ");
?>

<?php
Yii::app()->clientScript->registerScript( 'deletePayment', "
        jQuery( function($){
            $('#payment_cart').on('click','a.delete-payment',function(e) {
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
            $('div#comment_content').on('change','#comment_id',function(e) {
                e.preventDefault();
                var comment=$(this).val();
                $.ajax({
                        url: 'SetComment',
                        data : {comment : comment},
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

<?php /*
    Yii::app()->clientScript->registerScript( 'paymentOption', "
        jQuery( function($){
            $('div#payment_cart').on('change','#payment_type_id',function(e) {
                e.preventDefault();
                var payment_type=$(this).val();
                if (payment_type==='Debt')
                {
                    $('#payment_amount_id').val(0);
                }
            });
        });
      ");
 *
 */
?>

<?php
/*Yii::app()->clientScript->registerScript( 'selectProduct', "
        jQuery( function($){
            $('div#product_show').on('click','a.list-product',function(e) {
                e.preventDefault();
                $('#myModal').modal('hide');
                var remote = $('#SaleItem_item_id');
                var url=$(this).attr('href');
                var gridCart=$('#grid_cart');
                var totalCart=$('#total_cart');
                var paymentCart=$('#payment_cart');
                var cancelCart=$('#cancel_cart');
                $.ajax({url:url,
                        dataType : 'json',
                        type : 'post',
                        beforeSend: function() { $('.waiting').show(); },
                        complete: function() { $('.waiting').hide(); },
                        success : function(data) {
                                if (data.status==='success')
                                {
                                    gridCart.html(data.div_gridcart);
                                    totalCart.html(data.div_totalcart);
                                    paymentCart.html(data.div_paymentcart);
                                    cancelCart.html(data.div_cancelcart);
                                    if (data.items==0)
                                    {
                                         $('div#payment_cart').hide();
                                    }
                                    remote.select2('open');
                                }
                                else
                                {
                                  alert('something worng');
                                  return false;
                                }
                          }
                });
             });
         });
      ");
*/
?>

<?php
Yii::app()->clientScript->registerScript( 'priceTierOption', "
        jQuery( function($){
            $('div#client_cart').on('change','#price_tier_id',function(e) {
                e.preventDefault();
                var pricetierId=$(this).val();
                $.ajax({url: 'SetPriceTier',
                        data : {price_tier_id : pricetierId},
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

<?php if  (Yii::app()->settings->get('sale', 'disableConfirmation')=='1') { ?>
    <script>
        $(document).ready(function()
        {
            $('#payment_cart').on('click','a.complete-sale',function(e) {
                e.preventDefault();
                $("#finish_sale_button").hide();
                $('#finish_sale_form').submit();
                $("#SaleItem_client_id").focus();
                return false;
            });
        });
    </script>
<?php } else { ?>
    <script>
        $(document).ready(function()
        {
            $('#payment_cart').on('click','a.complete-sale',function(e) {
                e.preventDefault();
                $("#finish_sale_button").hide();
                if (confirm("<?php echo Yii::t('app','Are you sure you want to submit this sale? This cannot be undone.'); ?>")){
                    $('#finish_sale_form').submit();
                } else { //Bring back submit and unmask if fail to confirm
                    $("#finish_sale_button").show();
                }
            });
        });
    </script>
<?php } ?>

<script>

    var submitting = false;

    $(document).ready(function()
    {
        //Here just in case the loader doesn't go away for some reason
        $('.waiting').hide();

        // ajaxForm to ensure is submitting as Ajax even user press enter key
        $('#add_item_form').ajaxForm({target: "#register_container", beforeSubmit: salesBeforeSubmit, success: itemScannedSuccess});

        $('.line_item_form').ajaxForm({target: "#register_container", beforeSubmit: salesBeforeSubmit});

        $('#total_discount_form').ajaxForm({target: "#register_container", beforeSubmit: salesBeforeSubmit});

        $('#suspend_sale_form').ajaxForm({target: "#register_container", beforeSubmit: salesBeforeSubmit});

        $('#cart_contents').on('change','input.input-grid',function(e) {
            e.preventDefault();
            $(this.form).ajaxSubmit({target: "#register_container", beforeSubmit: salesBeforeSubmit });
        });

        $('#cancel_cart').on('click','a.suspend-sale',function(e) {
            e.preventDefault();
            if (confirm("<?php echo Yii::t('app','Are you sure you want to suspend this sale?'); ?>")){
                $('#suspend_sale_form').attr('action', '<?php echo Yii::app()->createUrl('saleItem/CompleteSale/',array('action_status' => Yii::app()->params['order_status_suspend'])); ?>');
                $('#suspend_sale_form').submit();
                //location.reload();
            }
        });

        $('#cancel_cart').on('click','a.cancel-sale',function(e) {
            e.preventDefault();
            if (confirm("<?php echo Yii::t('app','Are you sure you want to clear this sale? All items will cleared.'); ?>")){
                $('#suspend_sale_form').attr('action', '<?php echo Yii::app()->createUrl('saleItem/CompleteSale/',array('action_status' => Yii::app()->params['order_status_cancel'])); ?>');
                $('#suspend_sale_form').ajaxSubmit({target: "#register_container", beforeSubmit: salesBeforeSubmit});
                //location.reload();
            }
        });

        $('#client_cart').on('click','a.detach-customer', function(e) {
            e.preventDefault();
            $('#client_selected_form').ajaxSubmit({target: "#register_container", beforeSubmit: salesBeforeSubmit, success: clientScannedSuccess});
        });

        $('#total_discount_cart').on('change','input.input-totaldiscount',function(e) {
            e.preventDefault();
            $(this.form).ajaxSubmit({target: "#register_container", beforeSubmit: salesBeforeSubmit });
        });

        $('#payment_cart').on('click','a.complete-sale', function(e) {
            e.preventDefault();
            $('#finish_sale_form').ajaxSubmit({target: "#register_container", beforeSubmit: salesBeforeSubmit, success: clientScannedSuccess });
        });

    });

    function salesBeforeSubmit(formData, jqForm, options)
    {
        if (submitting)
        {
            return false;
        }
        submitting = true;
        $('.waiting').show();
    }


    function itemScannedSuccess(responseText, statusText, xhr, $form)
    {
        //$('.waiting').hide();
        setTimeout(function(){$('#SaleItem_item_id').focus();}, 10);
    }

    // really thanks to this http://www.stefanolocati.it/blog/?p=1413
    function qtyScannedSuccess(itemId)
    {
        return function (responseText, statusText, xhr, $form ) {
            setTimeout(function(){$('#quantity_' + itemId).select();}, 10);
        }
    }

    function clientScannedSuccess(responseText, statusText, xhr, $form)
    {
        setTimeout(function(){$('#SaleItem_client_id').focus();}, 10);
    }


</script>

<?php if (Common::getSaleID()!==NULL) { ?>
    <script>
        $('#sidebar').on('click','a',function(e) {
            e.preventDefault();
            if (confirm("<?= Yii::t('app', 'click OK to save you work before you leave here'); ?>")) {
                $('#suspend_sale_form').attr('action', '<?php echo Yii::app()->createUrl('saleItem/CompleteSale/', array('action_status' => Yii::app()->params['order_status_suspend'])); ?>');
                $('#suspend_sale_form').ajaxSubmit({target: "#register_container"});
                var host = window.location.origin;
                location.href = host + $(this).attr("href");
                return true;
            } else {
                return false;
            }
        });
    </script>
    <!--<script>
    $("#sidebar").on('click','a', function(e){
        e.preventDefault();
        var curr_link = window.location.href;
        var host = window.location.origin;
        var clicked_link = host + $(this).attr("href");
        var url = "/SaleItem/CompleteSale/?action_status=2";

        if (curr_link != clicked_link) {
            //var answer=confirm('Your process will be suspend if you leave this current page, Are you sure?');
            if (confirm('click OK to save you work before you leave here')) {
                $.ajax({
                    url: url,
                    type: 'POST',
                    success: function (data) {
                        location.href = clicked_link;
                        return false;
                    }
                });
                return false;
            } else {
                return false;
            }
        }

    });
    </script>-->
<?php } ?>


<!--<script>
    var warnMessage = "You have unsaved changes on this page!";

    $(document).ready(function() {
        $('input:not(:button,:submit),textarea,select').change(function () {
            window.onbeforeunload = function () {
                if (warnMessage != null) return warnMessage;
            }
        });
        $('input:submit').click(function(e) {
            warnMessage = null;
        });
    });
</script>-->



<script type="text/javascript" language="javascript">
    $(document).keydown(function(event)
    {
        var mycode = event.keyCode;

        //F1
        if ( mycode === 112) {
            $('#SaleItem_item_id').focus();
            $('#SaleItem_item_id').select();
        }

        //F2 focus to customer selection
        if ( mycode === 113) {
            $('#SaleItem_client_id').focus();
            $('#SaleItem_client_id').select();
        }

        //F3 focus to payment amount
        if ( mycode === 115) {
            $('#payment_amount_id').focus();
            $('#payment_amount_id').select();
        }

        //ESC
        if ( mycode === 27) {
            $("#finish_sale_button").focus();
        }
    });
</script>