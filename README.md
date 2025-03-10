# Influencer App

## Tech stack

- Modash [API](https://docs.modash.io/)
- Ruby 3.3.5
- Ruby on Rails 8.0.1
- Stimulus
- Turbo (Frames and Streams)
- Tailwind 4
- Postgresql 17
- Solid Cable
- Solic Queue
- Gems:
  - solid_cache
  - solid_queue
  - solid_cable
  - kaminari
  - tailwindcss-rails

## Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)

## Overview
This is an influencers application built with **Ruby on Rails 8**. It allows users to view and create influencers, either manually or from the api. It includes a great user experience thanks to turbo.

## Features
- **Influencers View**: Users can view influencers who come from the API.
- **Influencers creation**: Users can create influencers manually from the application.
- **Influencers searching**: Users can search influencers by their name from the application.
- **Pagination**: Influencers are paginated using `kaminari`.

## Installation

1. **Clone the Repository**:
    ```bash
    git clone git@github.com:SegundoRP/influencers_project.git
    cd influencers_project
    ```

2. **Install Dependencies**:
    ```bash
    bundle install
    ```

3. **Set Up Database**:
    ```bash
    rails db:create
    rails db:migrate
    ```

4. **Set Up API Keys and passwords**:
    For influencers data, set up your `modash_access_token` API key in your credentials variables:
    ```bash
    EDITOR="your-favorite-editor(example: code) --wait" bin/rails credentials:edit
    ```

5. **Run the Application**:
    ```bash
    bin/dev
    ```

## Usage

### Influencers information
Users can view the influencers information through the web interface. These information come to the **Modash API** and include some elements like: username, fullname, followers, platform, account verified and others more.

### Influencers creation
- The user can create influencers manually.
- Use the search functions to manage influencers.


## Configuration

### Credentials Variables

- `modash_access_token`: API key for fetching influencers data.
