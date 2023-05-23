final categories = <String, List<String>>{
  "electronic": [
    "electronic-subcategory-computer",
    "electronic-subcategory-headphones",
    "electronic-subcategory-phone",
    "electronic-subcategory-other",
  ],
  "pet": [
    "pet-subcategory-bird",
    "pet-subcategory-cat",
    "pet-subcategory-dog",
    "pet-subcategory-exotic",
    "pet-subcategory-other",
  ]
};

class Post {
  final int postId;
  final String categoryId;
  final int userId;
  final String title;
  final String text;
  final String address;
  final String imageUrl;
  final String city;
  const Post({
    required this.postId,
    required this.categoryId,
    required this.userId,
    required this.text,
    required this.title,
    required this.address,
    required this.imageUrl,
    required this.city,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      postId: json["postId"],
      categoryId: json["categoryId"],
      userId: json["userId"],
      text: json["text"],
      title: json["title"],
      address: json["address"],
      imageUrl: json["imageUrl"],
      city: json["city"],
    );
  }
}

const defaultUser = User(
  email: "",
  emailVerified: false,
  firstName: "",
  lastName: "",
  password: "",
  phoneNumber: "",
  profilePicture: "",
  userId: 0,
  userName: "",
);

class User {
  final int userId;
  final String email;
  final String password;
  final String profilePicture;
  final String userName;
  final String firstName;
  final String lastName;
  final bool emailVerified;
  final String phoneNumber;

  const User({
    required this.userId,
    required this.email,
    required this.emailVerified,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.phoneNumber,
    required this.profilePicture,
    required this.userName,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json["email"],
      userId: json["userId"],
      userName: json["userName"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      password: json["password"],
      phoneNumber: json["phoneNumber"],
      profilePicture: json["profilePicture"],
      emailVerified: json["emailVerified"],
    );
  }
}

class Category {
  final String categoryId;
  final String name;
  final List<SubCategory> subCategories;
  final int postCount;

  const Category({
    required this.categoryId,
    required this.name,
    required this.postCount,
    required this.subCategories,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryId: json["categoryId"],
      name: json["name"],
      subCategories: json["subCategories"],
      postCount: json["postCount"],
    );
  }
}

class SubCategory {
  final String subCategoryId;
  final String subCategoryName;
  final String categoryId;

  const SubCategory({
    required this.categoryId,
    required this.subCategoryName,
    required this.subCategoryId,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      categoryId: json["categoryId"],
      subCategoryName: json["subCategoryName"],
      subCategoryId: json["subCategoryId"],
    );
  }
}

// export interface ISubCategory {
//   subCategoryId: string,
//   subCategoryName: string,
//   categoryId: string
// }

// export interface ICategory {
//   categoryId: string,
//   name: string,
//   subCategories: Array<ISubCategory>,
//   postCount: number
// }

// export interface IUser {
//   userId: number,
//   email: string,
//   password: string,
//   profilePicture: string,
//   username: string,
//   firstName: string,
//   lastName: string,
//   emailVerified: boolean,
//   phoneNumber: string
// }
