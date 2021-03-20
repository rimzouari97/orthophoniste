
import 'package:orthophoniste/Screens/Home/level2/TileModel_img.dart';

String selectedTile = "";
int selectedIndex ;
bool selected = true;
int points = 0;

List<TileModelImage> myPairs = new List<TileModelImage>();
List<bool> clicked = new List<bool>();

List<bool> getClicked(){

  List<bool> yoClicked = new List<bool>();
  List<TileModelImage> myairs = new List<TileModelImage>();
  myairs = getPairs();
  for(int i=0;i<myairs.length;i++){
    yoClicked[i] = false;
  }

  return yoClicked;
}

List<TileModelImage>  getPairs(){

  List<TileModelImage> pairs = new List<TileModelImage>();

  TileModelImage tileModel = new TileModelImage();

  //1
  tileModel.setImageAssetPath("assets/speaker.png");
  tileModel.setSound("cat.mp3");
  tileModel.setIsSelected(false);
  pairs.add(tileModel);
  pairs.add(tileModel);
  tileModel = new TileModelImage();

  //2
  tileModel.setImageAssetPath("assets/speaker.png");
  tileModel.setIsSelected(false);
  tileModel.setSound("dog.wav");
  pairs.add(tileModel);
  pairs.add(tileModel);
  tileModel = new TileModelImage();

  //3
  tileModel.setImageAssetPath("assets/speaker.png");
  tileModel.setIsSelected(false);
  tileModel.setSound("elephant.wav");
  pairs.add(tileModel);
  pairs.add(tileModel);
  tileModel = new TileModelImage();

  //4
  tileModel.setImageAssetPath("assets/speaker.png");
  tileModel.setIsSelected(false);
  tileModel.setSound("lion.wav");
  pairs.add(tileModel);
  pairs.add(tileModel);
  tileModel = new TileModelImage();
  //5
  tileModel.setImageAssetPath("assets/speaker.png");
  tileModel.setIsSelected(false);
  tileModel.setSound("wolf.wav");
  pairs.add(tileModel);
  pairs.add(tileModel);
  tileModel = new TileModelImage();

  //6
  tileModel.setImageAssetPath("assets/speaker.png");
  tileModel.setIsSelected(false);
  tileModel.setSound("cat.mp3");
  pairs.add(tileModel);
  pairs.add(tileModel);
  tileModel = new TileModelImage();

  //7
  tileModel.setImageAssetPath("assets/speaker.png");
  tileModel.setIsSelected(false);
  tileModel.setSound("cat.mp3");
  pairs.add(tileModel);
  pairs.add(tileModel);
  tileModel = new TileModelImage();

  //8
  tileModel.setImageAssetPath("assets/speaker.png");
  tileModel.setIsSelected(false);
  tileModel.setSound("cat.mp3");
  pairs.add(tileModel);
  pairs.add(tileModel);
  tileModel = new TileModelImage();

//  print(pairs.first.toString());

  return pairs;
}

List<TileModelImage>  getQuestionPairs(){

  List<TileModelImage> pairs = new List<TileModelImage>();

  TileModelImage tileModel = new TileModelImage();

  //1
  tileModel.setImageAssetPath("assets/question.png");
  tileModel.setIsSelected(false);
  pairs.add(tileModel);
  pairs.add(tileModel);
  tileModel = new TileModelImage();

  //2
  tileModel.setImageAssetPath("assets/question.png");
  tileModel.setIsSelected(false);
  pairs.add(tileModel);
  pairs.add(tileModel);
  tileModel = new TileModelImage();

  //3
  tileModel.setImageAssetPath("assets/question.png");
  tileModel.setIsSelected(false);
  pairs.add(tileModel);
  pairs.add(tileModel);
  tileModel = new TileModelImage();

  //4
  tileModel.setImageAssetPath("assets/question.png");
  tileModel.setIsSelected(false);
  pairs.add(tileModel);
  pairs.add(tileModel);
  tileModel = new TileModelImage();
  //5
  tileModel.setImageAssetPath("assets/question.png");
  tileModel.setIsSelected(false);
  pairs.add(tileModel);
  pairs.add(tileModel);
  tileModel = new TileModelImage();

  //6
  tileModel.setImageAssetPath("assets/question.png");
  tileModel.setIsSelected(false);
  pairs.add(tileModel);
  pairs.add(tileModel);
  tileModel = new TileModelImage();

  //7
  tileModel.setImageAssetPath("assets/question.png");
  tileModel.setIsSelected(false);
  pairs.add(tileModel);
  pairs.add(tileModel);
  tileModel = new TileModelImage();

  //8
  tileModel.setImageAssetPath("assets/question.png");
  tileModel.setIsSelected(false);
  pairs.add(tileModel);
  pairs.add(tileModel);
  tileModel = new TileModelImage();

  return pairs;
}