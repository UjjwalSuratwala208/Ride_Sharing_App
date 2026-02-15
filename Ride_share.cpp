#include <iostream>
#include <iomanip>
#include <memory>
#include <string>
#include <vector>
#include <sstream>

using std::cout;
using std::endl;
using std::string;

// -------------------- Ride (Base Class) --------------------
class Ride {
private:
    int rideID;
    string pickupLocation;
    string dropoffLocation;
    double distanceMiles; // encapsulated
public:
    Ride(int id, string pickup, string dropoff, double distance)
        : rideID(id), pickupLocation(std::move(pickup)),
          dropoffLocation(std::move(dropoff)), distanceMiles(distance) {}

    virtual ~Ride() = default;

    // Encapsulation: read-only access via methods (no public fields)
    int getRideID() const { return rideID; }
    string getPickupLocation() const { return pickupLocation; }
    string getDropoffLocation() const { return dropoffLocation; }
    double getDistanceMiles() const { return distanceMiles; }

    // Polymorphism: overridden in subclasses
    virtual double fare() const {
        // Default: basic per-mile pricing
        const double baseFee = 2.00;
        const double perMile = 1.50;
        return baseFee + (perMile * distanceMiles);
    }

    virtual string rideType() const { return "Ride"; }

    virtual string rideDetails() const {
        std::ostringstream oss;
        oss << "[" << rideType() << "] "
            << "RideID=" << rideID
            << ", " << pickupLocation << " -> " << dropoffLocation
            << ", Distance=" << std::fixed << std::setprecision(1) << distanceMiles
            << " mi, Fare=$" << std::fixed << std::setprecision(2) << fare();
        return oss.str();
    }
};

// -------------------- StandardRide (Derived) --------------------
class StandardRide : public Ride {
public:
    using Ride::Ride;

    double fare() const override {
        const double baseFee = 2.00;
        const double perMile = 1.50;
        return baseFee + (perMile * getDistanceMiles());
    }

    string rideType() const override { return "StandardRide"; }
};

// -------------------- PremiumRide (Derived) --------------------
class PremiumRide : public Ride {
public:
    using Ride::Ride;

    double fare() const override {
        const double baseFee = 5.00;
        const double perMile = 3.00;
        return baseFee + (perMile * getDistanceMiles());
    }

    string rideType() const override { return "PremiumRide"; }
};

// -------------------- Driver --------------------
class Driver {
private:
    int driverID;
    string name;
    double rating;

    // Encapsulation: keep assignedRides private
    std::vector<std::shared_ptr<Ride>> assignedRides;

public:
    Driver(int id, string n, double r)
        : driverID(id), name(std::move(n)), rating(r) {}

    void addRide(const std::shared_ptr<Ride>& ride) {
        assignedRides.push_back(ride);
    }

    string getDriverInfo() const {
        std::ostringstream oss;
        oss << "DriverID=" << driverID << ", Name=" << name
            << ", Rating=" << std::fixed << std::setprecision(1) << rating
            << ", CompletedRides=" << assignedRides.size();
        return oss.str();
    }

    void printCompletedRides() const {
        cout << "---- Driver Completed Rides ----" << endl;
        for (const auto& r : assignedRides) {
            cout << r->rideDetails() << endl; // polymorphic call
        }
    }
};

// -------------------- Rider --------------------
class Rider {
private:
    int riderID;
    string name;

    // Encapsulation: keep requestedRides private
    std::vector<std::shared_ptr<Ride>> requestedRides;

public:
    Rider(int id, string n) : riderID(id), name(std::move(n)) {}

    void requestRide(const std::shared_ptr<Ride>& ride) {
        requestedRides.push_back(ride);
    }

    void viewRides() const {
        cout << "---- Rider Ride History ----" << endl;
        cout << "RiderID=" << riderID << ", Name=" << name
             << ", RequestedRides=" << requestedRides.size() << endl;

        for (const auto& r : requestedRides) {
            cout << r->rideDetails() << endl; // polymorphic call
        }
    }
};

// -------------------- Main Demo --------------------
int main() {
    // Create rides (polymorphism: store different types together)
    std::vector<std::shared_ptr<Ride>> rides;
    rides.push_back(std::make_shared<StandardRide>(101, "NJIT", "Newark Penn", 3.2));
    rides.push_back(std::make_shared<PremiumRide>(202, "Jersey City", "Manhattan", 8.5));

    // Rider requests rides
    Rider rider(1, "Ujjwal");
    for (const auto& r : rides) rider.requestRide(r);

    // Driver completes rides
    Driver driver(10, "Alex", 4.8);
    for (const auto& r : rides) driver.addRide(r);

    // Demonstrate polymorphism on a list
    cout << "=== Polymorphic Ride List ===" << endl;
    for (const auto& r : rides) {
        cout << r->rideDetails() << endl;
    }
    cout << endl;

    cout << driver.getDriverInfo() << endl;
    driver.printCompletedRides();
    cout << endl;

    rider.viewRides();
    return 0;
}
