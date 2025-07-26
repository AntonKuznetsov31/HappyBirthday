**HappyBirthday**

This version represents approximately 7–8 hours of focused development.

**Input validation:**
  - Name must consist of two parts (first name and last name), only letters, minimum 2 characters each.
  - Birthday must be a valid date in the past, with age under 5 years.

**Age display:**
  - Calculates age from birthday.
  - Displays either in months (1–11) or years (1–5), using digit images (e.g. digit_3).
  - Age string correctly pluralizes ("1 MONTH" vs "2 MONTHS").

**Data persistence:**
  - Baby profile (name, birthday, image) is saved locally using SwiftData.

**Custom navigation:**
  - Uses NavigationStack with enum-based routing.

**What I want to do next:**

- Add a loading indicator during image rendering (the first tap on "Share" causes a visible delay).
- Fix z-index issue in the photo picker to make it be shown under the background image.
- Improve layout constraints on the birthday screen (especially spacing between top and bottom vstacks).
