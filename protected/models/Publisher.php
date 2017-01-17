<?php

/**
 * This is the model class for table "publisher".
 *
 * The followings are the available columns in table 'publisher':
 * @property integer $id
 * @property string $name
 * @property string $location
 * @property string $contact_name
 * @property string $contact_email
 * @property string $contact_tel
 *
 * The followings are the available model relations:
 * @property Item[] $items
 */
class Publisher extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'publisher';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('name', 'required'),
			array('name, location, contact_name', 'length', 'max'=>100),
			array('contact_email', 'length', 'max'=>50),
			array('contact_tel', 'length', 'max'=>25),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id, name, location, contact_name, contact_email, contact_tel', 'safe', 'on'=>'search'),
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
			'items' => array(self::HAS_MANY, 'Item', 'publisher_id'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id' => 'ID',
			'name' => 'Name',
			'location' => 'Location',
			'contact_name' => 'Contact Name',
			'contact_email' => 'Contact Email',
			'contact_tel' => 'Contact Tel',
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
		$criteria->compare('name',$this->name,true);
		$criteria->compare('location',$this->location,true);
		$criteria->compare('contact_name',$this->contact_name,true);
		$criteria->compare('contact_email',$this->contact_email,true);
		$criteria->compare('contact_tel',$this->contact_tel,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return Publisher the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
        
        protected function getPublisherInfo()
        {
            return $this->name;
        }
        
        public function getPublisher()
        {
            $model = Publisher::model()->findAll();
            $list  = CHtml::listData($model , 'id', 'PublisherInfo');
            return $list;
        }
        
        public static function getPublisher2($name = '') {

            // Recommended: Secure Way to Write SQL in Yii 
            $sql = 'SELECT id ,name AS text 
                    FROM publisher 
                    WHERE name LIKE :name
                    ';
            
            $pub_name = '%' . $name . '%';
            
            return Yii::app()->db->createCommand($sql)->queryAll(true, array(':name' => $pub_name));
        }
        
        public function savePublisher($publisher_name)
        {
            $publisher_id=null;
            $exists = Publisher::model()->exists('id=:publisher_id',array(':publisher_id'=>(int) $publisher_name ));
            if (!$exists) {
                $publisher= new Publisher;
                $publisher->name=$publisher_name;
                $publisher->save();
                $publisher_id=$publisher->id;
            }
            return $publisher_id;
        }
                
        
}
