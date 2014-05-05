/**
  * streetNamesMain.pde
  * Street Names App for the Natal Museum
  * Interactive touch screen application for exploring the people that the streets and places
  * of Pietermaritzburg are named after.
  * by Lyndon Daniels 17 April 2013
  * You are free to redistribute and use this code under the terms of the GPL version 3
  * Please direct all further enquiries to lyndon@lyndondaniels.com
 **/

//Libraries*****************************************************************************************************************************************************

//Declaration***************************************************************************************************************************************************

//Video Objects

//Sound Objects

//Fonts
PFont font, fontQ;

//Image Objects
//intro
PImage Eimg, Zimg;
PImage introBkg, introMask, introTitle;
PImage[] introBtn = new PImage[12];
PImage[] introBtnS = new PImage[12];
//main
PImage[] mainBkg = new PImage[12];
PImage[] headM = new PImage[12];
PImage[] mapBtnTM = new PImage[12];
PImage[] panoBtnTM = new PImage[12];
PImage txtMaskM, arrowDn;
PImage closeE, closeZ;
//map
PImage[] map = new PImage[12];
PImage[] mapBkg = new PImage[12];
PImage[] mapMask = new PImage[12];
PImage attrib;
//pano
PImage[] pano = new PImage[12];
PImage panoMask, panoText;

//Global Variables**********************************************************************************************************************************************

//mouse X and Y
int mx, my;

//Intro------------------------------------
int xOffset;
int introBtnX;
float introBtnSCos;
int introBtnSX;
String who;
int indexM;
boolean introDrag;
String lang;
String namesTmp;

//Main-------------------------------------
String imgName;
//String closeBtnM;
String[][] mainStr = new String[12][10];
String[][] mainStrZ = new String[12][10];
//Down arrow for text on Main, mapping var
int dnArrowT;

//Map--------------------------------------
String[][] mapStr = new String[12][10];
String[][] mapStrZ = new String[12][10];

//Pano-------------------------------------
String[][] panoStr = new String[12][10];
String[][] panoStrZ = new String[12][10];

int textHeight;

//Main and Map
int tempNumM;
int yOffset;
int by;

//Determine position of user's mouse
String userFocus;

//Map
int txtMapYpos;

//Pano
int panoMaxNum;
int panoPtX;

//Main names in names.txt 
String[] names;

//scene can be intro, main, map, pano
String scene; 

//Offsets and Constants--------------------

//Set font characteristics
int fontSize = 18;
int specificWidth = 600;
int specificWidthMap = 280;
int lineSpacing = 6;

int INTROSOFFEST = 50;

//Main
//Main screen text
int TEXTMX = 630;
int TEXTMY = 420;
//Main arrows Offset
int ARROWXOFFEST = 25;
//Main Map Button Y Offest
int MAPBTNYOFFSET = 320;
int MAPBTNXOFFSET = 50;
//Main Pano Button Offset
int PANOBTNXOFFSET = 300;

//Map
int MAPXOFFSET = 15;
int TEXTMAPX = 1070;

//Pano
int PANOXBIG = 720;
int PANOXSML = 646;
int PANOXSCALESML = 547;
int PANOXSCALEBIG = 819;
int PANOSCALE = 50;
int PANOYOFFSET = 20;
//Set the maximum amount of loops that the pano image can be used in
//this is to gracefully exit the Pano screen without causing excessive system overhead
//increase with caution!
int PANOSYSMAX = 500;

//Innitialization***********************************************************************************************************************************************

void setup(){
  //Fullscreen
  size(1366,768);
  
  //Populate arrays
  names = loadStrings("names.txt"); 
  
  //Load Images Here
  //intro-----------------------------------
  Eimg = loadImage("E.png");
  Zimg = loadImage("Z.png");
  introBkg = loadImage("introBkgMain.jpg");
  introMask = loadImage("bkgMask.png");
  //introTitle = loadImage("introTitle.png");
  
  //Main------------------------------------
  txtMaskM = loadImage("txtMaskM.png");
  closeE = loadImage("closeE.png");
  closeZ = loadImage("closeZ.png");
  arrowDn = loadImage("arrowDn.png");
  
  //Map-------------------------------------
  attrib = loadImage("map/attrib.png");
  
  //Panorama--------------------------------
  panoMask = loadImage("pano/panoMask.png");
  panoText = loadImage("panoText.png");
 
  //Populate Image arrays
  for(int i = 0; i < names.length; i++){
    //Populate Intro Button Image array 
    imgName = names[i] + ".png";
    introBtn[i] = loadImage(imgName);
    
    //Button Shadow Image Array
    imgName = names[i] + "S.png";
    introBtnS[i] = loadImage(imgName);
    
    //Populate Main Background Image Array
    imgName = names[i] + "M.jpg";
    mainBkg[i] = loadImage(imgName);
    
    //Populate Headings
    imgName = names[i] + "H.png";
    headM[i] = loadImage(imgName);
    
    //Populate Map Button Thumb for Main
    imgName = "thumbs/" + names[i] + "MapBtn.png";
    mapBtnTM[i] = loadImage(imgName);
    
    //Populate Pano Button Thumb for Main
    imgName = "thumbs/" + names[i] + "PanoBtnT.png";
    panoBtnTM[i] = loadImage(imgName);
    
    //Populate Map Array
    imgName = "map/" + names[i] + "Map.png";
    map[i] = loadImage(imgName);
    
    //Populate Map Bgk Array
    imgName = "map/" + names[i] + "BkgMap.jpg";
    mapBkg[i] = loadImage(imgName);
    
    //Populate Map Mask Array
    imgName = "map/" + names[i] + "MapMask.png";
    mapMask[i] = loadImage(imgName);
    
    //Populate Panorama Array
    imgName = "pano/" + names[i] + "Pano.jpg";
    pano[i] = loadImage(imgName);
  }
  
  //Text Array
  //Populate the mainStr containing paragraphs of all 12 .txt files
  //Populate Quotes for map screen
  //Populate info for Pano screen
  //All populations 12 .txt files *2 for languages
  for(int i = 0; i < names.length; i++){
    //Populate English Docs Main
    namesTmp = "txt/" + names[i] + "E.txt";
    mainStr[i] = loadStrings(namesTmp);
    //Populate Zulu Docs Main
    namesTmp = "txt/" + names[i] + "Z.txt";
    mainStrZ[i] = loadStrings(namesTmp);
    //Populate English Quotes Map
    namesTmp = "txt/" + names[i] + "QE.txt";
    mapStr[i] = loadStrings(namesTmp);
    //Populate Zulu Quotes Map
    namesTmp = "txt/" + names[i] + "QZ.txt";
    mapStrZ[i] = loadStrings(namesTmp);
    //Populate English Pano info
    namesTmp = "txt/" + names[i] + "PanoE.txt";
    panoStr[i] = loadStrings(namesTmp);
    //Populate Zulu Pano info
    namesTmp = "txt/" + names[i] + "PanoZ.txt";
    panoStrZ[i] = loadStrings(namesTmp);
  }
  
  //Initialize Globals------------------------------
  scene = "intro";
  introDrag = false;
  lang = "Z";
  //Main
  userFocus = "close";
  
  //Set font properties
  //Font for Main
  font = loadFont("FreeSans-18.vlw");
  textFont(font,fontSize);
  //Font for Map Quotes
  fontQ = loadFont("Garuda-Oblique-18.vlw");
  
  //Hide the cursor
  noCursor();
 
}

//Force Fullscreen Mode
boolean sketchFullScreen() {
  return true;
}

//Draw*MAIN******************************************************************************************************************************************************

void draw(){
  background(introBkg);
  if (scene == "intro"){
     //renders buttons images and shadows, whoF() checks for the user's focus
     dispBtnF();
   }else if(scene == "main"){
     //Set font to non-italics
     textFont(font,fontSize);
     dispM();
     dispTxtM();
     dispMapBtn();
     dispPanoBtn();
     dispArrows();
     dispHead();
     dispLang();
     dispClose();
   }else if (scene == "map"){
     //Set font to italics
     textFont(fontQ,fontSize);
     dispMapBkg();
     dispMap();
     dispMapMask();
     dispTxtMap();
     dispHead();
     dispLang();
     dispClose();
     //Google Maps attribution
     image(attrib, 50, height - 40);
   }else if (scene == "pano"){
    //Pano test will change text alignment to CENTER, does not use calculateTextHeight()
    //each text file only has one array element. (see namePanoE/Z.txt)
    dispPano();
    dispPanoMask();
    dispHead();
    dispPanoTxt();
    dispLang();
    dispClose();
   } 
   
}
//End Draw*END_MAIN***********************************************************************************************************************************************

//User Functions*************************************************************************************************************************************************

//MOUSE-------------------------------------------------------------------------------------------
void mousePressed(){
  //set drag buttons offset :intro drag
  if (scene == "intro"){
    xOffset = mouseX - introBtnX;
    introDrag = false;
  }else if (scene == "main"){
    //Determine user's focus
    userFocusF();
    //Drag Text
    yOffset = mouseY-by; 
  }else if (scene == "map"){
    yOffset = mouseY-by;
    userFocusF();
  }else if (scene == "pano"){
    userFocusF();
  }
}
//////////////////////////////////////////////////////////////////////////////////////////////////
void mouseDragged(){
  //set position of buttons :intro drag
  if(scene == "intro"){
    introBtnX = mouseX - xOffset;
    introDrag = true;
    //println(introBtnX);
  }else if (scene == "main" && lang == "E"){
//replace above with scene is equal to main or map and set zulu translation below for dispTxtM()
    by = mouseY-yOffset;

  }else if (scene == "main" && lang == "Z"){
   // 
   if((by + TEXTMY) < ((TEXTMY +250) - calculateTextHeight(mainStrZ[indexM], specificWidth, fontSize, lineSpacing))){
     //by =  TEXTMY - calculateTextHeight(mainStr[indexM], specificWidth, fontSize, lineSpacing);
     by = by;
     println("up");
    }
    else if ((by + TEXTMY) > TEXTMY){
     by--;
    println("dragged too far down");
    }else{ 
    by = mouseY-yOffset;
    }
  }//Major setter
   else if ( scene == "map"){
   // 
   by = mouseY-yOffset;
  }
}
//////////////////////////////////////////////////////////////////////////////////////////////////
void mouseReleased(){
  //select the main screen
  if(scene == "intro" && !introDrag && userFocus == "close"){
    whoF();
    //change to next scene from intro
    scene = "main";
    //println(who);
  }else if (scene == "main" && userFocus == "close"){
    scene = "intro";
    //Reset all objects dragged on Y axis
    by = 0;
  }else if (scene == "main" && userFocus == "language"){
    if (lang == "E"){
      lang = "Z";
    }else if (lang == "Z"){
      lang = "E";
    }else{
      println("No language selected");
    }
  }else if (scene == "main" && userFocus == "map"){
    scene = "map";
  }else if (scene == "main" && userFocus == "pano"){
    scene = "pano";
    panoPtX = 0;
    panoMaxNum = 0;
  }else if (scene == "map" && userFocus == "close"){
    scene = "main";
    userFocus = "none";
    //Reset all objects dragged on Y axis
    by = 0;
  }else if (scene == "map" && userFocus == "language"){
    if (lang == "E"){
      lang = "Z";
      userFocus = "none";
    }else if (lang == "Z"){
      lang = "E";
      userFocus = "none";
    }else{
      println("No language selected");
    }
  }else if (scene == "pano" && userFocus == "close"){
    scene = "main";
    userFocus = "none";
  }else if (scene == "pano" && userFocus == "language"){
    if (lang == "E"){
      lang = "Z";
      userFocus = "none";
    }else if (lang == "Z"){
      lang = "E";
      userFocus = "none";
    }else{
      println("No language selected");
    }
  }
}
//END_MOUSE-----------------------------------------------------------------------------------------
//Mouse Related Functions-----------------------------------------------------------------------------------------------------------------------------------------

//Determine the position of the user's interactive focal point. Used everywhere except Intro.
String userFocusF(){
  mx = mouseX;
  my = mouseY;
  
  if (scene == "intro"){
    //skip this part handled by whoF() onRelease
  }else if (scene == "main"){
    //valid positions include: language, close, map, pano, text
    //Language button selection-type
    if(mx >= 0 && my >= 0 && mx <= Eimg.width && my <= Eimg.height){
      userFocus = "language";
      //println(userFocus);
    }//Close button selection-type
     else if (mx >= width - closeE.width && my >= 0 && mx <= width && my <= closeE.height){
       userFocus = "close";
       //println(userFocus);
     }//Text object(!OOP) selection-type
     else if (mx >= TEXTMX && my >= TEXTMY && mx <= width && my <= height){
      userFocus = "text";
      //println(userFocus);
     }//Map button selection-type
     else if (mx >= TEXTMX - MAPBTNXOFFSET && my >= TEXTMY - MAPBTNYOFFSET 
              && mx <= TEXTMX - MAPBTNXOFFSET + mapBtnTM[indexM].width 
              && my <= TEXTMY - MAPBTNYOFFSET + mapBtnTM[indexM].height){
      userFocus = "map";
      //println(userFocus);
     }//Pano button selection-type
     else if (mx >= TEXTMX - MAPBTNXOFFSET + PANOBTNXOFFSET && my >= TEXTMY - MAPBTNYOFFSET
              && mx <= TEXTMX - MAPBTNXOFFSET + PANOBTNXOFFSET + panoBtnTM[indexM].width
              && my <= TEXTMY - MAPBTNYOFFSET + panoBtnTM[indexM].height){
      userFocus = "pano";
      //println(userFocus);
     }//No selection
     else{ 
      userFocus = "Please choose A Language, the Close button, A Map, A Panorama or Drag the Text";
      println("userFocus");
     }     
  }else if (scene == "map"){
    //map focus options are close and language
     if (mx >= width - closeE.width && my >= 0 && mx <= width && my <= closeE.height){
       userFocus = "close";
       //println(userFocus);
     }else if (mx >= 0 && my >= 0 && mx <= Eimg.width && my <= Eimg.height){
       userFocus = "language";
     }
  }else if (scene == "pano"){
    //Valid selections are language and close
     if (mx >= width - closeE.width && my >= 0 && mx <= width && my <= closeE.height){
       userFocus = "close";
       //println(userFocus);
     }else if (mx >= 0 && my >= 0 && mx <= Eimg.width && my <= Eimg.height){
      userFocus = "language";
      //println(userFocus + " " + scene);
     } 
  }else{
    text("Invalid Scene Selection", width/2, height/2);
    userFocus = "none";
  }
  return userFocus;
} 

//Main index value to select person used in Intro where userFocusF() is not used
int whoF(){
 for (int i = 0; i < names.length; i++){
   //checks the first row of buttons. 6 in total. then checks remaining 6 in following branch
   if (scene == "intro" && i < names.length/2 && mouseX >= introBtnX + introBtn[i].width *i 
      && mouseX <= introBtnX + introBtn[i].width *i + introBtn[i].width 
      && mouseY < height/2){
      who = names[i];
      //println(who);
      indexM = i;
     }else if (scene == "intro" && i >= names.length/2 && mouseX >= introBtnX + introBtn[i].width *(i-6)
             && mouseX <= introBtnX + introBtn[i].width *(i-6) + introBtn[i].width 
             && mouseY >= height/2){
             who = names[i];
             //println(who);
             indexM = i;
             }
     }
     return indexM;
}

//Intro Functions-------------------------------------------------------------------------------------------------------------------------------------------------

//Display function for the Intro Screen
void dispBtnF(){
  
  //Render the first row of buttons. only 6 i.e. length/2
  for(int i = 0; i < names.length/2; i++){
   //check for normal position of buttons i.e. not too far right or left 
   if(scene == "intro" && introBtnX <= width/2 - introBtn[0].width && introBtnX >=  int(-introBtn[0].width*3.5)){
      //Render Button Shadow with left to right position relative to Button pos   
      image(introBtnS[i], (introBtnX + introBtnS[i].width *i) + (cos(introBtnSCos)*INTROSOFFEST), 0);
      //Render Buttons
      image(introBtn[i], introBtnX + introBtn[i].width *i, 0);
      }//Check if Buttons have moved too far left and correct
       else if (scene == "intro" && introBtnX < int(-introBtn[0].width*3.5)){
        introBtnX = int(-introBtn[0].width*3.5);
        image(introBtnS[i], (introBtnX + introBtnS[i].width *i) + (cos(introBtnSCos)*INTROSOFFEST), 0);
        image(introBtn[i], introBtnX + introBtn[i].width *i, 0);
      }//Check if Buttons have moved too far right and correct
       else if (scene == "intro" && introBtnX > width/2 - introBtn[0].width){
        introBtnX = width/2 - introBtn[0].width;
        image(introBtnS[i], (introBtnX + introBtnS[i].width *i) + (cos(introBtnSCos)*INTROSOFFEST), 0);
        image(introBtn[i], introBtnX + introBtn[i].width *i, 0);
      }
   }
 //Render second row of buttons x Pos matching first row (i-6) 
  for(int i = 6; i < names.length; i++){
    //inherit button X pos from previous loop
    image(introBtnS[i], (introBtnX + introBtnS[i].width *(i-6)) + (cos(introBtnSCos)*INTROSOFFEST), 375);
    image(introBtn[i], introBtnX + introBtn[i].width *(i-6), 375);
  }
  
  //Draw the mask that fades the buttons at the left and right edges
  image(introMask, 0, 0);
  
  //Map button X pos to cos curve
  introBtnSCos = map(introBtnX, int(-introBtn[0].width*3.5), width/2 - introBtn[0].width, 0 , PI);
 
}

//Main Functions---------------------------------------------------------------------------------------------------------------------------------------------------

//Render the background................USER DISPLAY FUNCTION
void dispM(){
  image(mainBkg[indexM],0,0);
}

//Render the Close button..............USER DISPLAY FUNCTION
void dispClose(){
  if (lang == "E"){
    image(closeE, width - closeE.width, 0);
  }else if (lang == "Z"){
    image(closeZ, width - closeZ.width, 0);
  }
}

//Render Map Thumbnails.................USER DISPLAY FUNCTION
void dispMapBtn(){
  image(mapBtnTM[indexM], TEXTMX - MAPBTNXOFFSET, TEXTMY - MAPBTNYOFFSET);
}

//Render Pano Thumbnails................USER DISPLAY FUNCTION
void dispPanoBtn(){
  image(panoBtnTM[indexM], TEXTMX - MAPBTNXOFFSET + PANOBTNXOFFSET, TEXTMY - MAPBTNYOFFSET);
}

//Render Main Headings..................USER DISPLAY FUNCTION
void dispHead(){
  image(headM[indexM],0,0);
}

//Render the Language selection Button..USER DISPLAY FUNCTION
void dispLang(){
  if (lang == "E"){
    image(Zimg, 0,0);
  }else if (lang == "Z"){
    image(Eimg, 0,0);
  }else{
    text("Invalid Language Selection",0,0);
  }
}

//Render the text USER FUNCTION/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void dispTxtM(){
  //Main Language Choice
  if(lang == "E"){
    fill(50);
     //Check if text has been dragged too far up
     if((by + TEXTMY) < ((TEXTMY +250) - calculateTextHeight(mainStr[indexM], specificWidth, fontSize, lineSpacing))){
         by =  +250 - calculateTextHeight(mainStr[indexM], specificWidth, fontSize, lineSpacing);
         //Exclude first paragraph so as not to get index out of bounds and redundant multiple renderings
         text(mainStr[indexM][0], TEXTMX, by + TEXTMY,specificWidth,1000);
         //start loop from 1 as 0 is rendered in previous line  
         for (int i = 1; i < mainStr[indexM].length; i++){
           //tempNum to add the previous paragraph's height to the current paragraph to be rendered
           tempNumM += calculateTextHeight2(mainStr[indexM][i-1], specificWidth, fontSize, lineSpacing);  
           text(mainStr[indexM][i], TEXTMX, by + TEXTMY + tempNumM ,specificWidth,1000);
           }
         tempNumM = 0;
         image(txtMaskM,0,0);
         println("dragged too far up");
      }//Check if Text has been dragged too far down
      else if ((by + TEXTMY) > TEXTMY){
        by = 0;
        //Exclude first paragraph so as not to get index out of bounds and redundant multiple renderings
         text(mainStr[indexM][0], TEXTMX,  TEXTMY,specificWidth,1000);
         //start loop from 1 as 0 is rendered in previous line  
         for (int i = 1; i < mainStr[indexM].length; i++){
           //tempNum to add the previous paragraph's height to the current paragraph to be rendered
           tempNumM += calculateTextHeight2(mainStr[indexM][i-1], specificWidth, fontSize, lineSpacing);  
           text(mainStr[indexM][i], TEXTMX,  TEXTMY + tempNumM ,specificWidth,1000);
           }
         tempNumM = 0;
         image(txtMaskM,0,0);
         println("down");
      }//Default dragability of text
      else{
         //Exclude first paragraph so as not to get index out of bounds and redundant multiple renderings
         text(mainStr[indexM][0], TEXTMX, by + TEXTMY,specificWidth,1000);
         //start loop from 1 as 0 is rendered in previous line  
         for (int i = 1; i < mainStr[indexM].length; i++){
            //tempNum to add the previous paragraph's height to the current paragraph to be rendered
            tempNumM += calculateTextHeight2(mainStr[indexM][i-1], specificWidth, fontSize, lineSpacing);  
            text(mainStr[indexM][i], TEXTMX, by + TEXTMY + tempNumM ,specificWidth,1000);
          }
    tempNumM = 0;
    image(txtMaskM,0,0);
    }
 
   }
    //Render in another language (else for major structure)
    else if (lang == "Z"){
    fill(50);
    //Check if text has been dragged too far up
     if((by + TEXTMY) < ((TEXTMY +250) - calculateTextHeight(mainStrZ[indexM], specificWidth, fontSize, lineSpacing))){
         by =  +250 - calculateTextHeight(mainStrZ[indexM], specificWidth, fontSize, lineSpacing);
         //Exclude first paragraph so as not to get index out of bounds and redundant multiple renderings
         text(mainStrZ[indexM][0], TEXTMX, by + TEXTMY,specificWidth,1000);
         //start loop from 1 as 0 is rendered in previous line  
         for (int i = 1; i < mainStrZ[indexM].length; i++){
           //tempNum to add the previous paragraph's height to the current paragraph to be rendered
           tempNumM += calculateTextHeight2(mainStrZ[indexM][i-1], specificWidth, fontSize, lineSpacing);  
           text(mainStrZ[indexM][i], TEXTMX, by + TEXTMY + tempNumM ,specificWidth,1000);
           }
         tempNumM = 0;
         image(txtMaskM,0,0);
         println("dragged too far up");
      }//Check if Text has been dragged too far down
      else if ((by + TEXTMY) > TEXTMY){
        by = 0;
        //Exclude first paragraph so as not to get index out of bounds and redundant multiple renderings
         text(mainStrZ[indexM][0], TEXTMX,  TEXTMY,specificWidth,1000);
         //start loop from 1 as 0 is rendered in previous line  
         for (int i = 1; i < mainStrZ[indexM].length; i++){
           //tempNum to add the previous paragraph's height to the current paragraph to be rendered
           tempNumM += calculateTextHeight2(mainStrZ[indexM][i-1], specificWidth, fontSize, lineSpacing);  
           text(mainStrZ[indexM][i], TEXTMX,  TEXTMY + tempNumM ,specificWidth,1000);
           }
         tempNumM = 0;
         image(txtMaskM,0,0);
         println("down");
      }//Default dragability of text
      else{
         //Exclude first paragraph so as not to get index out of bounds and redundant multiple renderings
         text(mainStrZ[indexM][0], TEXTMX, by + TEXTMY,specificWidth,1000);
         //start loop from 1 as 0 is rendered in previous line  
         for (int i = 1; i < mainStrZ[indexM].length; i++){
            //tempNum to add the previous paragraph's height to the current paragraph to be rendered
            tempNumM += calculateTextHeight2(mainStrZ[indexM][i-1], specificWidth, fontSize, lineSpacing);  
            text(mainStrZ[indexM][i], TEXTMX, by + TEXTMY + tempNumM ,specificWidth,1000);
          }
    tempNumM = 0;
    image(txtMaskM,0,0);
    }
  }else{
    text("Please Make a Language Selection", TEXTMX, TEXTMY);
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Render the ARROWS for the Main screen.USER DISPLAY FUNCTION
void dispArrows(){
  if (lang == "Z"){
    dnArrowT = int(map(by + TEXTMY, TEXTMY, (TEXTMY +250) - calculateTextHeight(mainStrZ[indexM], specificWidth, fontSize, lineSpacing),128,0));
    tint(255,dnArrowT);
    image(arrowDn, TEXTMX + ARROWXOFFEST, height - arrowDn.height);
    tint(255);
  }else if (lang == "E"){
    dnArrowT = int(map(by + TEXTMY, TEXTMY, (TEXTMY +250) - calculateTextHeight(mainStr[indexM], specificWidth, fontSize, lineSpacing),128,0));
    tint(255,dnArrowT);
    image(arrowDn, TEXTMX + ARROWXOFFEST, height - arrowDn.height);
    tint(255);
  }
}

//Determine the total size of the text block///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int calculateTextHeight(String strings[], int specificWidth, int fontSize, int lineSpacing) {
  String[] wordsArray;
  String tempString = "";
  int numLines = 0;
  float textHeight;
 
 for(int n = 0; n < strings.length; n++){
   //split paragraphs into words and populate array 
   wordsArray = split(strings[n], " ");
   
   for (int i=0; i < wordsArray.length; i++) {
     if (textWidth(tempString + wordsArray[i]) < specificWidth) {
        tempString += wordsArray[i] + " ";
        }else{
         tempString = wordsArray[i] + " ";
         numLines++;
        }
    }
  
  numLines++; //adds the last line
  //println(numLines);
 }  
  textHeight = numLines * (textDescent() + textAscent() + lineSpacing);
  return(round(textHeight));
}

//Render paragraphs consecutively without overlaps/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int calculateTextHeight2(String string, int specificWidth, int fontSize, int lineSpacing) {
  String[] wordsArray;
  String tempString = "";
  int numLines = 0;
  float textHeight2;
  //Split paragraphs into array of words
   wordsArray = split(string, " ");
 
  for(int i=0; i < wordsArray.length; i++) {
    if(textWidth(tempString + wordsArray[i]) < specificWidth) {
       tempString += wordsArray[i] + " ";
       }else{
         tempString = wordsArray[i] + " ";
         numLines++;
       }
    }
  
  numLines++; //adds the last line
  //println(numLines);
  
  textHeight2 = numLines * (textDescent() + textAscent() + lineSpacing);
    //println(textHeight2);
  return(round(textHeight2));

}

//Map User Functions------------------------------------------------------------------------------------------------------------------------------------------------
//Render the background..........USER DISPLAY FUNCTION
void dispMapBkg(){
  image(mapBkg[indexM], 0,0);
}

//Render the Map.................USER DISPLAY FUNCTION
void dispMap(){
  if (by < height - map[indexM].height -50){
    by = height - map[indexM].height -50;
    image(map[indexM], MAPXOFFSET, height - map[indexM].height -50);
  }else if (by > 50){
    by = 50;
    image(map[indexM], MAPXOFFSET, 50);
  }
  else{
  image(map[indexM], MAPXOFFSET, by);
  }
}

//Render the Mask...............USER DISPLAY FUNCTION
void dispMapMask(){
  image(mapMask[indexM],0,0);
}

//Render the text...............USER DISPLAY & INTERACTION FUNCTION
void dispTxtMap(){
  if(lang == "E"){
    fill(50);
    //Exclude first paragraph so as not to get index out of bounds and redundant multiple renderings
    txtMapYpos = height/2 - (calculateTextHeight(mapStrZ[indexM], specificWidthMap, fontSize, lineSpacing))/2 ;
    text(mapStr[indexM][0], TEXTMAPX,txtMapYpos,specificWidthMap,1000);
    //start loop from 1 as 0 is rendered in previous line  
    for (int i = 1; i < mapStr[indexM].length; i++){
      //tempNum to add the previous paragraph's height to the current paragraph to be rendered
      tempNumM += calculateTextHeight2(mapStr[indexM][i-1], specificWidthMap, fontSize, lineSpacing);  
      text(mapStr[indexM][i], TEXTMAPX, txtMapYpos + tempNumM ,specificWidthMap,1000);
      }
    tempNumM = 0;
    //image(txtMaskM,0,0);
   }else if (lang == "Z"){
    fill(50);
    //Exclude first paragraph so as not to get index out of bounds and redundant multiple renderings
    txtMapYpos = height/2 - (calculateTextHeight(mapStrZ[indexM], specificWidthMap, fontSize, lineSpacing))/2 ;
    text(mapStrZ[indexM][0], TEXTMAPX, txtMapYpos,specificWidthMap,1000);
    //start loop from 1 as 0 is rendered in previous line  
    for (int i = 1; i < mapStrZ[indexM].length; i++){
      //tempNum to add the previous paragraph's height to the current paragraph to be rendered
      tempNumM += calculateTextHeight2(mapStrZ[indexM][i-1], specificWidthMap, fontSize, lineSpacing);  
      text(mapStrZ[indexM][i], TEXTMAPX, txtMapYpos + tempNumM ,specificWidthMap,1000);
      }
    tempNumM = 0;
    println(txtMapYpos);
    println(calculateTextHeight(mapStrZ[indexM], specificWidthMap, fontSize, lineSpacing));
    //image(txtMaskM,0,0);
  }else{
    text("Please Make a Language Selection", TEXTMAPX, TEXTMY);
  }
}

//Panorama User Functions-------------------------------------------------------------------------------------------------------------------------------------------
//render panorama image...........USER DISPLAY & INTERACTION FUNCTION
void dispPano(){
  mx = mouseX;
  my = mouseY;
  if (mx > PANOXBIG && my > Eimg.height){
    panoPtX += ((mx - PANOXSCALESML)/PANOSCALE);
  }else if (mx < PANOXSML && my > Eimg.height){
    panoPtX += ((mx - PANOXSCALEBIG)/PANOSCALE);
  }else{
    //do nothing
  } 
  //Safely Exit Panoram
  if (panoMaxNum > PANOSYSMAX){
    panoPtX = 0;
    panoMaxNum = 0;
    scene = "main";
    userFocus = "none";
  }else{
  panoMaxNum = abs(int(panoPtX/pano[indexM].width)) + 2;
  for (int i = 1; i < panoMaxNum; i ++){
    image(pano[indexM], -panoPtX, PANOYOFFSET);
    image(pano[indexM], -panoPtX - (i * pano[indexM].width), PANOYOFFSET);
    image(pano[indexM], -panoPtX + (i * pano[indexM].width), PANOYOFFSET);
    } 
  }
}
//Render the Panorama mask
void dispPanoMask(){
  image(panoMask,0,0);
}

//Render info text for pano screen in the center with graphic
void dispPanoTxt(){
  image(panoText, width/2 - panoText.width/2, height - panoText.height);
  if (lang == "E"){
    textAlign(CENTER);
    text(panoStr[indexM][0], width/2, height - panoText.height/4);
    textAlign(LEFT);
  }else if (lang == "Z"){
    textAlign(CENTER);
    text(panoStrZ[indexM][0], width/2, height - panoText.height/4);
    textAlign(LEFT);
  }else{
    textAlign(CENTER);
    text("Please make a valid language selection" , width/2, height - panoText.height/4);
    textAlign(LEFT);
  }
}

