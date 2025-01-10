import mysql.connector
from mysql.connector import Error

# Database connection configuration
DATABASE_CONFIG = {
    'host': 'localhost',
    'user': 'root',  # Replace with your MySQL username
    'password': 'SVNITcse#2',  # Replace with your MySQL password
    'database': 'Airline_reservation_system'
}


def create_connection():
    """Create a database connection."""
    try:
        connection = mysql.connector.connect(**DATABASE_CONFIG)
        if connection.is_connected():
            return connection
    except Error as e:
        print(f"Error: {e}")
        return None

def fetch_data(query, params=None):
    """Fetch data from the database."""
    connection = create_connection()
    if connection:
        try:
            cursor = connection.cursor(dictionary=True)
            cursor.execute(query, params)
            result = cursor.fetchall()
            return result
        except Error as e:
            print(f"Error: {e}")
        finally:
            cursor.close()
            connection.close()


def add_user():
    """Insert a new user into the Users table."""
    connection = create_connection()
    if connection:
        try:
            cursor = connection.cursor()
            print("\nEnter User Details:")
            first_name = input("First Name: ")
            last_name = input("Last Name: ")
            email = input("Email: ")
            password = input("Password: ")
            phone = input("Phone (optional): ")
            address = input("Address (optional): ")
            date_of_birth = input("Date of Birth (YYYY-MM-DD): ")
            username = input("Username: ")

            query = """
                INSERT INTO Users (first_name, last_name, email, password, phone, address, date_of_birth, username)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
            """
            cursor.execute(query, (first_name, last_name, email, password, phone, address, date_of_birth, username))
            connection.commit()
            print("User added successfully.")
        except Error as e:
            print(f"Error: {e}")
        finally:
            cursor.close()
            connection.close()

def login():
    """Authenticate user login."""
    connection = create_connection()
    if connection:
        try:
            cursor = connection.cursor(dictionary=True)
            print("\nUser Login:")
            email = input("Enter your email: ")
            password = input("Enter your password: ")

            # Query to check email and password
            query = "SELECT * FROM Users WHERE email = %s AND password = %s"
            cursor.execute(query, (email, password))
            user = cursor.fetchone()

            if user:
                print(f"\nWelcome, {user['first_name']} {user['last_name']}!")
                return user  # Return user details if login is successful
            else:
                print("Invalid email or password. Please try again.")
                return None
        except Error as e:
            print(f"Error: {e}")
        finally:
            cursor.close()
            connection.close()

def book_flight(user_id, flight_id, first_name, last_name, email, phone, date_of_birth, passport_number):
    """Call the BookFlight stored procedure to book a flight."""
    connection = create_connection()
    if connection:
        try:
            cursor = connection.cursor()
            cursor.callproc('BookFlight', [user_id, flight_id, first_name, last_name, email, phone, date_of_birth, passport_number])
            connection.commit()
            print("Flight booked successfully.")
        except Error as e:
            print(f"Error: {e}")
        finally:
            cursor.close()
            connection.close()



def delete_booking(booking_id):
    """Call the DeleteBooking stored procedure to delete a booking."""
    connection = create_connection()
    if connection:
        try:
            cursor = connection.cursor()
            # Call the DeleteBooking stored procedure to delete the booking
            cursor.callproc('DeleteBooking', [booking_id])

            # Commit the transaction to persist the changes
            connection.commit()

            print(f"Booking with ID {booking_id} deleted successfully.")
        except Error as e:
            print(f"Error: {e}")
        finally:
            cursor.close()
            connection.close()


def update_flight_price(flight_id, new_price):
    """Call the UpdateFlightPrice stored procedure to update a flight price."""
    connection = create_connection()
    if connection:
        try:
            cursor = connection.cursor()
            cursor.callproc('UpdateFlightPrice', [flight_id, new_price])
            connection.commit()

            print("Flight price updated successfully.")
        except Error as e:
            print(f"Error: {e}")
        finally:
            cursor.close()
            connection.close()

def get_flight_details():
    """Fetch flight details from the FlightDetails view."""
    query = "SELECT * FROM FlightDetails"
    return fetch_data(query)

def get_passenger_details():
    """Fetch passenger details from the PassengerDetails view."""
    query = "SELECT * FROM PassengerDetails"
    return fetch_data(query)

def main_menu():
    """Display the main menu and handle user input."""
    while True:
        print("\n--- Airline Reservation System ---")
        print("1. Signup a new user")
        print("2. Loging")
        print("3. View Flight Details")
        print("4. View Passenger Details")
        print("5. Book a Flight")
        print("6. Delete Flight")
        print("7. Update Flight Price")
        print("8. Exit")
        choice = input("Enter your choice (1-8): ")

        if choice == '1':
            add_user()

        elif choice == '2':
            login()

        elif choice == '3':
            flights = get_flight_details()
            print("\nFlight Details:")
            for flight in flights:
                print(flight)

        elif choice == '4':
            passengers = get_passenger_details()
            print("\nPassenger Details:")
            for passenger in passengers:
                print(passenger)

        elif choice == '5':
            print("\n--- Book a Flight ---")
            user_id = int(input("Enter User ID: "))
            flight_id = int(input("Enter Flight ID: "))
            first_name = input("Enter First Name: ")
            last_name = input("Enter Last Name: ")
            email = input("Enter Email: ")
            phone = input("Enter Phone: ")
            date_of_birth = input("Enter Date of Birth (YYYY-MM-DD): ")
            passport_number = input("Enter Passport Number: ")
            book_flight(user_id, flight_id, first_name, last_name, email, phone, date_of_birth, passport_number)

        elif choice == '6':
            print("\n--- Delete Booking ---")
            booking_id_to_delete = int(input("Enter Booing ID: "))
            delete_booking(booking_id_to_delete)

        elif choice == '7':
            print("\n--- Update Flight Price ---")
            flight_id = int(input("Enter Flight ID: "))
            new_price = float(input("Enter New Price: "))
            update_flight_price(flight_id, new_price)

        elif choice == '8':
            print("Exiting the system. Goodbye!")
            break

        else:
            print("Invalid choice. Please try again.")

# Run the menu-driven application
if __name__ == "__main__":
    main_menu()