**HappyBirthday**

This version represents approximately 7–8 hours of focused development.

**Input validation:**
  - Name must consist of two parts (first name and last name), only letters, minimum 2 characters each.
  - Birthday must be a valid date in the past, with age under 5 years.

![Validation](https://github.com/AntonKuznetsov31/HappyBirthday/blob/main/Screenshots/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%202025-07-26%20%D0%B2%2019.06.32.png)

**Age display:**
  - Calculates age from birthday.
  - Displays either in months (1–11) or years (1–5), using digit images (e.g. digit_3).
  - Age string correctly pluralizes ("1 MONTH" vs "2 MONTHS").

**Data persistence:**
  - Baby profile (name, birthday, image) is saved locally using SwiftData.

**Custom navigation:**
  - Uses NavigationStack with enum-based routing.

**Localization**
  - All the text in the project is prepared to be localized

**iPad UI**
  - UI is adapted for both iPhones and iPads

![MainScreen](https://github.com/AntonKuznetsov31/HappyBirthday/blob/main/Screenshots/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%202025-07-27%20%D0%B2%2019.55.45.png)
![Sharing](https://github.com/AntonKuznetsov31/HappyBirthday/blob/main/Screenshots/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%202025-07-27%20%D0%B2%2019.56.09.png)

**What I want to do next:**

- Add a loading indicator during image rendering (the first tap on "Share" causes a visible delay).
~~- Fix z-index issue in the photo picker to make it be shown under the background image.~~
~~- Improve layout constraints on the birthday screen (especially spacing between top and bottom vstacks).~~

I've spent extra ±2 hours to refactor code and make some UI improvements
