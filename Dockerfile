# Use an official Flutter image as the base image
FROM cirrusci/flutter:stable

# Set the working directory in the container
WORKDIR /app

# Copy the pubspec.* files to the container
COPY pubspec.* ./

# Switch to a release channel
RUN flutter channel beta

# Upgrade Flutter
RUN flutter upgrade

# Install dependencies
RUN flutter pub get

# Copy the entire project directory to the container
COPY . .

# Build the Flutter project
RUN flutter build apk --release

# Expose port 8080 to the outside world
EXPOSE 8080

# Command to run the Flutter application
CMD ["flutter", "run", "--release", "--no-sound-null-safety", "--no-observatory", "--no-pub"]
