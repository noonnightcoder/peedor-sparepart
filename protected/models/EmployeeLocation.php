<?php

/**
 * This is the model class for table "employee_location".
 *
 * The followings are the available columns in table 'employee_location':
 * @property integer $id
 * @property integer $employee_id
 * @property integer $location_id
 * @property integer $home_status
 * @property string $created_at
 * @property string $updated_at
 * @property integer $created_by
 * @property integer $updated_by
 */
class EmployeeLocation extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'employee_location';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('employee_id, location_id', 'required'),
			array('employee_id, location_id, home_status, created_by, updated_by', 'numerical', 'integerOnly'=>true),
            array('updated_at','default',
                'value'=>new CDbExpression('NOW()'),
                'setOnEmpty'=>false,'on'=>'update'),
            array('created_at,updated_at','default',
                'value'=>new CDbExpression('NOW()'),
                'setOnEmpty'=>false,'on'=>'insert'),
			array('created_at, updated_at', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id, employee_id, location_id, home_status, created_at, updated_at, created_by, updated_by', 'safe', 'on'=>'search'),
		);
	}

	/**
	 * @return array relational rules.
	 */
	public function relations()
	{
		// NOTE: you may need to adjust the relation name and the related
		// class name for the relations automatically generated below.
		return array(
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id' => 'ID',
			'employee_id' => 'Employee',
			'location_id' => 'Location',
			'home_status' => 'Home Status',
			'created_at' => 'Created At',
			'updated_at' => 'Updated At',
			'created_by' => 'Created By',
			'updated_by' => 'Updated By',
		);
	}

	/**
	 * Retrieves a list of models based on the current search/filter conditions.
	 *
	 * Typical usecase:
	 * - Initialize the model fields with values from filter form.
	 * - Execute this method to get CActiveDataProvider instance which will filter
	 * models according to data in model fields.
	 * - Pass data provider to CGridView, CListView or any similar widget.
	 *
	 * @return CActiveDataProvider the data provider that can return the models
	 * based on the search/filter conditions.
	 */
	public function search()
	{
		// @todo Please modify the following code to remove attributes that should not be searched.

		$criteria=new CDbCriteria;

		$criteria->compare('id',$this->id);
		$criteria->compare('employee_id',$this->employee_id);
		$criteria->compare('location_id',$this->location_id);
		$criteria->compare('home_status',$this->home_status);
		$criteria->compare('created_at',$this->created_at,true);
		$criteria->compare('updated_at',$this->updated_at,true);
		$criteria->compare('created_by',$this->created_by);
		$criteria->compare('updated_by',$this->updated_by);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return EmployeeLocation the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}

	public static function saveEmployeeLocation($model,$location_id,$employee_id)
    {
        $emp_location = EmployeeLocation::model()->find('employee_id=:employeeID', array(':employeeID' => (int) $employee_id));

        if (!$emp_location) {
            $emp_location = New EmployeeLocation;
        }

        $emp_location->employee_id = $model->id;
        $emp_location->location_id = $location_id;
        $emp_location->home_status=1;
        $emp_location->created_by = 2;
        $emp_location->save();
    }

    public static function setEmployeeLocation($employee_id)
    {

        $emp_location = EmployeeLocation::model()->find('employee_id=:employeeID', array(':employeeID' => (int) $employee_id));

        if ($emp_location) {

            Yii::app()->session['location_id'] = $emp_location->location_id;

            //Yii::app()->getsetSession->setLocationId($emp_location->location_id);

            $location = Location::model()->findByPk($emp_location->location_id);

            Yii::app()->session['location_name'] = $location->name;
            Yii::app()->session['location_name_kh'] = $location->name_kh;
            Yii::app()->session['location_code'] = $location->loc_code;

            /*
            Yii::app()->getsetSession->setLocationCode($location->loc_code);
            Yii::app()->getsetSession->setLocationName($location->name);
            Yii::app()->getsetSession->setLocationNameKH($location->name_kh);
            Yii::app()->getsetSession->setLocationPhone($location->phone);
            Yii::app()->getsetSession->setLocationPhone1($location->phone1);
            Yii::app()->getsetSession->setLocationAddress($location->address);
            Yii::app()->getsetSession->setLocationAddress1($location->address1);
            Yii::app()->getsetSession->setLocationAddress2($location->address2);
            Yii::app()->getsetSession->setLocationWifi($location->wifi_password);
            Yii::app()->getsetSession->setLocationEmail($location->email);
            Yii::app()->getsetSession->setLocationPrinterFood($location->printer_food);
            Yii::app()->getsetSession->setLocationPrinterBeverage($location->printer_beverage);
            Yii::app()->getsetSession->setLocationPrinterReceipt($location->printer_receipt);
            Yii::app()->getsetSession->setLocationVat($location->vat);
            */
        }
}
}
