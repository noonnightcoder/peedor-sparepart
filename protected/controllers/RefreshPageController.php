<?php

class RefreshPageController extends Controller
{
    public function actionIndex()
    {
        $this->renderPartial('refresh_partial');
    }
}