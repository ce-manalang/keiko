# Keiko

Keiko is a simplified **shift management system** built with **Ruby on Rails, PostgreSQL, Tailwind CSS, and Hotwire**.

Schedulers can manage users and assign shifts, while Employees can view and acknowledge their assigned shifts through a clean, reactive interface.

---

## Tech Stack

* **Ruby on Rails 7**
* **PostgreSQL**
* **Hotwire (Turbo + Stimulus)**
* **Tailwind CSS**
* **RSpec** for testing

---

## Setup (Run Locally)

### 1. Clone the repository

```bash
git clone https://github.com/ce-manalang/keiko.git
cd keiko
```

---

### 2. Install dependencies

```bash
bundle install
```

---

### 3. Setup the database

Make sure **PostgreSQL is running**, then:

```bash
bin/rails db:create
bin/rails db:migrate
```

---

### 4. Start the development server

```bash
bin/dev
```

Open your browser at:

```
http://localhost:3000
```

---

## Running Tests

```bash
bundle exec rspec
```

---

## Project Goal

Deliver a minimal, production-ready **MVP shift scheduling tool** where:

* Schedulers manage **users and shifts**
* Employees **view and acknowledge** shifts
* The system prevents **overlapping schedules**
* UI feels **modern and reactive** with Hotwire

---

## License

This project is for learning and internal use.