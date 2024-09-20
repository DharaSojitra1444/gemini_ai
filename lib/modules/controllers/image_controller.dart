import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ImageController extends GetxController {
  RxInt selectStyleIndex = 0.obs;
  TextEditingController promptController = TextEditingController();


  final styleList = [
    {"title": "No Style", "image": "No Style"},
    {
      "title": "3D",
      "image":
          "https://media.istockphoto.com/id/1330874201/photo/girl-with-headphones-and-neon-lighting-stylized-3d-character.jpg?s=612x612&w=0&k=20&c=inPWNjMh8BjJfiPECra4y9MAWgADrldHUk_Xl0Ya9C0="
    },
    {"title": "Abstract", "image": "https://img.freepik.com/premium-photo/painting-woman-with-colorful-paint-her-face_403247-425.jpg"},
    {
      "title": "Anime",
      "image": "https://res.cloudinary.com/upwork-cloud/image/upload/c_scale,w_1000/v1709210962/catalog/1636985032308207616/mvi47nutkdrmymsg4jzx.webp"
    },
    {"title": "Cartoon", "image": "https://img.freepik.com/premium-photo/love-pet-animal_938045-131.jpg?size=626&ext=jpg"},
    {
      "title": "Digital Art",
      "image":
          "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgNLZBVrHeL9mg0c1HavJ0qtYXl2W7PEzWOA60KsAWARD3fFEmpx8lZ2pJ9_mS-1JymzSUtDz9g6V4__4u5XOVR7NN0jxPai2N0coSShL375Mw08sNLSH9I4y_KnPUFcRhch0UHqru_rQKI/w919/digital-art-landscape-uhdpaper.com-4K-4.1003-wp.thumbnail.jpg"
    },
    {"title": "Van Gogh", "image": "https://live.staticflickr.com/5761/30564034326_f67fbd15a8_b.jpg"},
    {"title": "Cyberpunk", "image": "https://ih1.redbubble.net/image.4997666794.8868/flat,750x,075,f-pad,750x1000,f8f8f8.u5.jpg"},
    {"title": "Watercolor", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSsx8YVOQGsKK5PPkzQ3rSurXcYJVeFAoUK2ncAmuA6eQ&s"},
    {"title": "Fantasy", "image": "https://e1.pxfuel.com/desktop-wallpaper/480/817/desktop-wallpaper-fantasy-landscape-epic-winter-fantasy.jpg"},
    {"title": "Video Game", "image": "https://www.cdmi.in/courses@2x/2D3D-Game-Design.webp"},
    {"title": "Ink", "image": "https://thumbs.dreamstime.com/b/ink-spots-18196647.jpg"},
    {"title": "Isometric", "image": "https://as2.ftcdn.net/v2/jpg/06/43/60/77/1000_F_643607781_uOD9Tuqrhqs1mM8W2ZQE4rZl8VqvrfjS.jpg"},
    {"title": "Mystical", "image": "https://as1.ftcdn.net/v2/jpg/06/44/92/12/1000_F_644921202_RSKcUUNgqzyDPM8lraqVImmkCwguPSEj.jpg"},
    {"title": "Mythology", "image": "https://as1.ftcdn.net/v2/jpg/05/61/07/86/1000_F_561078643_fivnRmdaPxRDCipKhdffZMPfTt2w7kUi.jpg"},
    {"title": "Nature", "image": "https://as1.ftcdn.net/v2/jpg/01/97/38/64/1000_F_197386409_Ads9KFmCESSdwmxcAF8oXWKwIegQB6kB.jpg"},
    {"title": "Oil Painting", "image": "https://t3.ftcdn.net/jpg/06/47/53/08/240_F_647530838_tu1RT4E8IfZJM6zViczvPB44gQsJlksT.jpg"},
    {"title": "Polaroid", "image": "https://www.photoland.in/wp-content/uploads/2022/03/Polaroid-Photo-print-3-600x600.jpg"},
    {"title": "Diorama", "image": "https://as2.ftcdn.net/v2/jpg/05/83/14/05/1000_F_583140595_J6IgaDIsaxYfC7EJdoP6C8eBQExvrEWg.jpg"},
    {
      "title": "Realistic",
      "image":
          "https://assets-global.website-files.com/632ac1a36830f75c7e5b16f0/64f11328a53b93124c98e589_OAhDtiyhI0sHyMpkMCW-jXREEwn9ohc3w880wiVcEzU.webp"
    },
    {"title": "Pop Art", "image": "https://t3.ftcdn.net/jpg/04/81/41/20/240_F_481412001_HgpZ31D4roPxxQSRvcYyRh1EAAOp4L4w.jpg"},
    {"title": "Steampunk", "image": "https://t3.ftcdn.net/jpg/05/78/90/18/240_F_578901867_PW8ADhXlqLzLYv8eWKmiZQk1XJ1kAJn5.jpg"},
    {"title": "StreetWear", "image": "https://as1.ftcdn.net/v2/jpg/06/73/12/44/1000_F_673124493_xuJvttLMJMdMhUo3MMUIYBi5W0rxzlF4.jpg"},
    {"title": "Street Art", "image": "https://graffstorm.com/wp-content/uploads/2022/03/graffiti-in-shoreditch-london-810x540.jpg"},
    {"title": "Floral", "image": "https://img.freepik.com/premium-photo/floral-girl_660634-239.jpg"},
    {"title": "Photo", "image": "https://cdn.shopify.com/s/files/1/1619/4221/files/4.1_Photo_by_Allef_Vinicius_on_Unsplash.jpg?v=1652251101"},
    {"title": "Etching", "image": "https://c7.alamy.com/comp/C7C11C/common-swift-vintage-engraving-old-engraved-illustration-of-common-C7C11C.jpg"},
    {"title": "Synth Wave", "image": "https://images5.alphacoders.com/130/1304409.jpeg"},
    {"title": "Ukiyo-e", "image": "https://r2.erweima.ai/imgcompressed/compressed_4df6db4d7f5facc252f5ac764415692a.webp"},
    {
      "title": "Epic",
      "image":
          "https://edm.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cq_auto:good%2Cw_1200/MTk5OTY1NjM3MzkxNTU3NzM1/jamal-eid-for-hard-summer-1.jpg"
    },
  ].obs;
}
