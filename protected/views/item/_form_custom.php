<div class="form-group">
    <label class="col-sm-3 control-label" for="Item_category"><?php echo Yii::t('app','Category') ?></label>
    <div class="col-sm-9">
        <?php
        $this->widget('yiiwheels.widgets.select2.WhSelect2', array(
            'asDropDownList' => false,
            'model'=> $model,
            'attribute'=>'category_id',
            'pluginOptions' => array(
                'placeholder' => Yii::t('app','Category'),
                'multiple'=>false,
                'width' => '50%',
                //'tokenSeparators' => array(',', ' '),
                'allowClear'=>true,
                //'minimumInputLength'=>1,
                'ajax' => array(
                    'url' => Yii::app()->createUrl('Category/GetCategory2/'),
                    'dataType' => 'json',
                    'cache'=>true,
                    'data' => 'js:function(term,page) {
                                            return {
                                                term: term, 
                                                page_limit: 10,
                                                quietMillis: 100, 
                                                apikey: "e5mnmyr86jzb9dhae3ksgd73" 
                                            };
                                        }',
                    'results' => 'js:function(data,page){
                                    return { results: data.results };
                                 }',
                ),
                'initSelection' => "js:function (element, callback) {
                                    var id=$(element).val();
                                    if (id!=='') {
                                        $.ajax('".$this->createUrl('/category/initCategory')."', {
                                            dataType: 'json',
                                            data: { id: id }
                                        }).done(function(data) {callback(data);});
                                    }
                            }",
                'createSearchChoice' => 'js:function(term, data) {
                                if ($(data).filter(function() {
                                    return this.text.localeCompare(term) === 0;
                                }).length === 0) {
                                    return {id:term, text: term, isNew: true};
                                }
                            }',
                'formatResult' => 'js:function(term) {
                                if (term.isNew) {
                                    return "<span class=\"label label-important\">New</span> " + term.text;
                                }
                                else {
                                    return term.text;
                                }
                            }',
            )));
        ?>
    </div>
</div>

<?php echo $form->textFieldControlGroup($model,'reorder_level',array('class'=>'span3')); ?>

<?php echo $form->textFieldControlGroup($model,'location',array('class'=>'span3','maxlength'=>20)); ?>

<?php //echo $form->textFieldControlGroup($model,'allow_alt_description',array('class'=>'span3')); ?>

<?php //echo $form->textFieldControlGroup($model,'is_serialized',array('class'=>'span4')); ?>

<?php echo $form->fileFieldControlGroup($model, 'image'); ?>

<?php echo $form->textAreaControlGroup($model,'description',array('rows'=>2, 'cols'=>10, 'class'=>'span3')); ?>

<?php if (Yii::app()->settings->get('item', 'itemExpireDate')=='1') { ?>
    <?php echo $form->checkBoxControlGroup($model, 'is_expire', array()); ?>

<?php } ?>

<?php //echo $form->dropDownListControlGroup($model,'count_interval', Item::itemAlias('stock_count_interval'),array('class'=>'span3','prompt'=>'-- Select --')); ?>

<?php //echo $form->textFieldControlGroup($model,'status',array('class'=>'span4')); ?>
