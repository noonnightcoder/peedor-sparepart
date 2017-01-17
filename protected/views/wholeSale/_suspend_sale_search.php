<?php //$this->widget( 'ext.modaldlg.EModalDlg' ); ?>
<?php $form=$this->beginWidget('bootstrap.widgets.TbActiveForm',array(
	'action'=>Yii::app()->createUrl($this->route),
	'method'=>'get',
        'layout'=>TbHtml::FORM_LAYOUT_INLINE,
)); ?>
        <span class="input-icon">
            <?php echo $form->textField($model,'search_client',array(
                            'size' => TbHtml::INPUT_SIZE_XXLARGE,
                            'maxlength'=>50,
                            'placeholder'=>Yii::t('app','Invoice No or Customer Name'),
                        )
                );  
            ?>
            <i class="ace-icon fa fa-search nav-search-icon blue"></i>
        </span>
        
        <?php echo TbHtml::submitButton('Search',  array('size' => TbHtml::BUTTON_SIZE_SMALL,'color' => TbHtml::BUTTON_COLOR_PRIMARY));?>

        <?php echo TbHtml::linkButton(Yii::t( 'app', 'New Sale' ),array(
                   'color'=>TbHtml::BUTTON_COLOR_SUCCESS,
                   'size'=>TbHtml::BUTTON_SIZE_SMALL,
                   'icon'=>'ace-icon fa fa-shopping-cart white',
                   'url'=>Yii::app()->createUrl('wholeSale/index',array('first_load'=>'Y')),
                   //'class'=>'update-dialog-open-link',
                   //'data-update-dialog-title' => Yii::t('app','New Whole Sale'),
           )); ?>

<?php $this->endWidget(); ?>

<br>
