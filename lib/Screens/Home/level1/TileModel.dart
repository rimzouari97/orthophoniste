class TileModel{

  String imageAssetPath;
  bool isSelected;
  String sound;

  TileModel({this.imageAssetPath, this.isSelected, this.sound});

  void setImageAssetPath(String getImageAssetPath){
    imageAssetPath = getImageAssetPath;
  }

  String getImageAssetPath(){
    return imageAssetPath;
  }

  void setIsSelected(bool getIsSelected){
    isSelected = getIsSelected;
  }

  bool getIsSelected(){
    return isSelected;
  }

 void setSound(String getSound){
    sound = getSound;
 }
 String getSound(){
    return sound;
 }
}