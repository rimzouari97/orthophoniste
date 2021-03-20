class TileModelImage{

  String imageAssetPath;
  bool isSelected;
  String sound;

  TileModelImage({this.imageAssetPath, this.isSelected, this.sound});

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

  @override
  String toString() {
    return 'TileModelImage{imageAssetPath: $imageAssetPath, isSelected: $isSelected, sound: $sound}';
  }
}