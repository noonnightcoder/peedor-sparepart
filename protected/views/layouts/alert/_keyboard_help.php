<i class="ace-icon fa fa-book"></i>
<?php echo TbHtml::tooltip(Yii::t('app','Keyboard Shortcuts Help'),'#',
    '[F1] => Set focus to "Search Item" 
            [F2] => Set focus to "Customer Box" 
            [F4] => Set focus to "Payment Box" 
            [ESC] => To Complete Sale',
    array('data-html' => 'true','placement' => TbHtml::TOOLTIP_PLACEMENT_TOP,)
); ?>

<!-- [ESC] => Set the focus to the "Cancel Sale". [Enter] will trigger the functionality <br> -->
