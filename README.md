# PongPong

Pong Pong Tales is the perfect app for parents who want to create lasting memories with their children through bedtime stories. With a vast library of kid books to choose from, parents can browse and select their favorites, and even search for specific titles.

The app's intuitive interface makes it easy to navigate through the library and add books to your favorites. Parents can also read books together with their children, or let the little ones enjoy them on their own. The app's clean and bright design makes it perfect for kids of all ages.

Pong Pong Tales is not only about reading, but also about learning. Many of the books featured in the app are educational, helping to foster a love of learning in children. From science and nature to history and culture, there is something for every curious young mind.

And with the ability to add books to your favorites, parents can quickly and easily create a personalized reading list for their children. Whether it's a beloved classic or a new and exciting adventure, Pong Pong Tales has something for everyone. Parents can create special memories with their children by reading the books together and discussing the stories

Pong Pong Tales is more than just an app – it's a tool for parents to connect with their children and create cherished memories. Start your bedtime story routine today with Pong Pong Tales.

## Prerequisites

- Xcode
- FirebaseFirestore
- Facebook Authentication

## How to setup

1. Setup the database

- Go to the Firebase Console.
- Click on "Add project" or select an existing project.
- Set up authentication providers (Apple, Google, and Facebook) in the Firebase project settings.
- Obtain the Google Services plist file for iOS integration.
- Add the plist file to the Xcode project.

2. Configure FirebaseFirestore

- Create three collections in your Firestore database: books, favorites, and recents.
- Define the following attributes for the books collection: contents, cover, description, rating, timestamp, and title.
- Set up the favorites and recent collections with the appropriate document structure, using authId as the document ID. In each document, add books collection and bookId as the documentId.

Please take a look at the models in my project to gain a clearer understanding.

## Contact Infomation

For further information or assistance, please feel free to contact me:

- LinkedIn: https://www.linkedin.com/in/kimlenghor/




