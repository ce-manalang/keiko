# keiko

**keiko** is a simplified **shift management system** built with **Ruby on Rails, PostgreSQL, Tailwind CSS, and Hotwire**.

Schedulers can manage users and assign shifts, while Employees can view and acknowledge their assigned shifts through a clean, reactive interface.

---

## Why the name “keiko”?

The name **keiko** is inspired by **Keiko Furukura**, the protagonist of the novel *Convenience Store Woman*.

Keiko Furukura is a woman who has worked part-time at a konbini for 18 years.
She finds comfort in:

* **Schedules**
* **Clear rules**
* **Predictable routines**
* **Following assigned shifts precisely**

This project borrows that spirit.

> **keiko is a shift management system that organizes employees and their schedules with clarity and structure.**

---

## Tech Stack

* **Ruby on Rails 8**
* **PostgreSQL**
* **Hotwire (Turbo + Stimulus)**
* **Tailwind CSS**
* **Flatpickr** for datetime UX
* **RSpec + Capybara** for testing

---

## Features

### Scheduler

* Manage **users (employees & schedulers)**
* Create, edit, and delete **shifts**
* Prevent **overlapping schedules**
* **Turbo-powered inline shift creation**
* **Stimulus live search** for users
* **Flatpickr datetime picker** for better UX

### Employee

* Personal **dashboard of assigned shifts**
* Clear **pending vs acknowledged** status
* **Turbo acknowledge** with instant UI update
* Secure access to **own shifts only**

---

# Scheduler Dashboard

The scheduler dashboard is the **administrative control center** of keiko.

Schedulers can:

* View all users
* Create and manage employees
* Assign and manage shifts
* Prevent overlapping schedules automatically

### Screenshots

|  |
|----------|
| <img width="1440" height="754" alt="Screenshot 2026-02-13 at 9 36 35 AM" src="https://github.com/user-attachments/assets/509f223e-5e6a-4649-b74c-8efc1c0999ae" /> |
| <img width="1431" height="751" alt="Screenshot 2026-02-13 at 9 37 28 AM" src="https://github.com/user-attachments/assets/e8ad1eb0-1e86-4503-b597-6f4c48cab03d" /> |

---

# Employee Dashboard

The employee dashboard is a **focused personal workspace**.

Employees can:

* View **only their assigned shifts**
* See **pending vs acknowledged** status
* **Acknowledge shifts instantly** via Turbo
* Experience a **clean, distraction-free UI**

### Screenshots

|  |
|----------|
| <img width="1440" height="754" alt="Screenshot 2026-02-13 at 9 38 41 AM" src="https://github.com/user-attachments/assets/06bb19d1-9981-4ea1-964b-73aaf296f750" /> |

---

# Running keiko Locally

## 1. Clone the repository

```bash
git clone https://github.com/ce-manalang/keiko.git
cd keiko
```

---

## 2. Install dependencies

```bash
bundle install
```

---

## 3. Setup the database

Make sure **PostgreSQL is running**, then:

```bash
bin/rails db:create
bin/rails db:migrate
bin/rails db:seed
```

The seed command creates:

* Demo **scheduler**
* Demo **employees**
* Sample **pending and acknowledged shifts**

### Demo login

```
Scheduler → scheduler@keiko.test / password
Employee  → alice@keiko.test / password
```

---

## 4. Start the development server

```bash
bin/dev
```

Open:

```
http://localhost:3000
```

---

## Running Tests

```bash
bundle exec rspec
```

---

## License

This project is for **learning, portfolio, and demonstration purposes**.

