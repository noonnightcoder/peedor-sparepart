<?php

/**
 * This is the model class for table "author".
 *
 * The followings are the available columns in table 'author':
 * @property integer $id
 * @property string $author_name
 * @property string $dob
 * @property string $mobile_no
 * @property string $email
 * @property string $address
 *
 * The followings are the available model relations:
 * @property Item[] $items
 */
class Author extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'author';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('author_name', 'required'),
			array('author_name, address', 'length', 'max'=>100),
			array('mobile_no', 'length', 'max'=>25),
			array('email', 'length', 'max'=>50),
			array('dob', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id, author_name, dob, mobile_no, email, address', 'safe', 'on'=>'search'),
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
			'items' => array(self::HAS_MANY, 'Item', 'author_id'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id' => 'ID',
			'author_name' => 'Author Name',
			'dob' => 'Dob',
			'mobile_no' => 'Mobile No',
			'email' => 'Email',
			'address' => 'Address',
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
		$criteria->compare('author_name',$this->author_name,true);
		$criteria->compare('dob',$this->dob,true);
		$criteria->compare('mobile_no',$this->mobile_no,true);
		$criteria->compare('email',$this->email,true);
		$criteria->compare('address',$this->address,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return Author the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}

    public function saveAuthor($author_name)
    {
        $author_id = null;
        $exists = Author::model()->exists('id=:author_id', array(':author_id' => (int)$author_name));
        if (!$exists) {
            $author = new Author;
            $author->author_name = $author_name;
            $author->save();
            $author_id = $author->id;
        }

        return $author_id;
    }


    public static function getAuthor2($name = '')
    {
        // Recommended: Secure Way to Write SQL in Yii
        $sql = "SELECT id ,author_name AS text
                FROM author
                WHERE author_name LIKE :name";

        $name = '%' . $name . '%';

        return Yii::app()->db->createCommand($sql)->queryAll(true, array(':name' => $name));
    }
}
