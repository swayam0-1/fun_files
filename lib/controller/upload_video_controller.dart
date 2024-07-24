import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fun_files/constant.dart';
import 'package:fun_files/models/video.dart';
import 'package:get/get.dart';
import 'package:video_compress/video_compress.dart';

class UploadVideoController extends GetxController{
  _compressVideo(String videoPath) async{
  final compressedVideo= await VideoCompress.compressVideo(
    videoPath,quality: VideoQuality.MediumQuality,);
  return compressedVideo!.file;
  }

 Future<String> _uploadVideoToStorage(String id,String videoPath) async{
    Reference ref=firebaseStorage.ref().child('videos').child(id);
    UploadTask uploadTask= ref.putFile(await _compressVideo(videoPath));
    TaskSnapshot snap=await uploadTask;
    String downloadUrl=await snap.ref.getDownloadURL();
    return downloadUrl;
  }

 Future<String> _uploadImageToStorage(String id,String videoPath) async{
    Reference ref=firebaseStorage.ref().child('thumbnails').child(id);
    UploadTask uploadTask=ref.putFile(await _getThumbnail(videoPath));
    TaskSnapshot snap=await uploadTask;
    String downloadUrl=await snap.ref.getDownloadURL();
    return downloadUrl;
  }
  _getThumbnail(String videoPath) async{
    final thumbnail=await VideoCompress.getByteThumbnail(videoPath);
    return thumbnail;
  }
//upload video
  upLoadVideo(String songName,String caption,String videopath) async{
    try{
      String uid=firebaseAuth.currentUser!.uid;
      DocumentSnapshot userDoc=await firestore.collection('user').doc(uid).get();
      //get id
      var allDoc=await firestore.collection('videos').get();
      int len =allDoc.docs.length;
      String videoUrl=await  _uploadVideoToStorage("Video $len",videopath);
     String thumbnail=await _uploadImageToStorage("Video $len", videopath);

     Video video=Video(
         username: (userDoc.data()! as Map<String,dynamic>)['name'],
         uid: uid,
         id: "Video $len",
         likes: [],
         commentCount: 0,
         shareCount: 0,
         songName: songName,
         caption: caption,
         videoUrl: videoUrl,
         thumbnail: thumbnail,
         profilePhoto: (userDoc.data()! as Map<String,dynamic>)['profilePhto'],
     );
     await firestore.collection('videos').doc('Video $len').set(
       video.toJson(),
     );
     Get.back();
    }catch(e){
      Get.snackbar(
        'Error Uploading Video',
        e.toString(),
      );
    }
  }
}