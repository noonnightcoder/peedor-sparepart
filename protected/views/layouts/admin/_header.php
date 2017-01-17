<div class="nav-search search-form" id="nav-search">
    <?php $this->renderPartial('//layouts/admin/_search', array(
        'model' => $model,
    )); ?>
</div>
<!-- search-form -->

<?php if (Yii::app()->user->checkAccess($check_access)) { ?>

    <?php echo TbHtml::linkButton(Yii::t('app', 'Add New'), array(
        'color' => TbHtml::BUTTON_COLOR_PRIMARY,
        'size' => TbHtml::BUTTON_SIZE_SMALL,
        'icon' => 'ace-icon fa fa-plus white',
        'url' => $this->createUrl($create_url),
        'class' => isset($class) ? $class : '',
        'data-refresh-grid-id' => isset($grid_id) ? $grid_id : '',
        'data-update-dialog-title' => isset($modal_title) ? Yii::t('app', $modal_title) : '',
    )); ?>

<?php } ?>



