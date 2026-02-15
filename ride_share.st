"========================
 GNU Smalltalk SAFE VERSION
========================"

"---------- Ride (Base Class) ----------"
Object subclass: Ride [
    | rideID pickupLocation dropoffLocation distance |

    Ride class >> withID: anID pickup: pick dropoff: drop distance: miles [
        ^ (self new)
            initializeWithID: anID pickup: pick dropoff: drop distance: miles;
            yourself
    ]

    initializeWithID: anID pickup: pick dropoff: drop distance: miles [
        rideID := anID.
        pickupLocation := pick.
        dropoffLocation := drop.
        distance := miles.   "Store distance as integer"
    ]

    rideID [ ^ rideID ]
    distance [ ^ distance ]

    fareCents [
        "Default: base $2 + $1.50 per mile
         Work in cents to avoid float issues"
        ^ (200 + (150 * distance))
    ]

    rideType [ ^ 'Ride' ]

    rideDetails [
        | dollars cents total |

        total := self fareCents.
        dollars := total // 100.
        cents := total \\ 100.

        ^ '[' , self rideType , '] '
          , 'RideID=' , rideID printString
          , ', ' , pickupLocation , ' -> ' , dropoffLocation
          , ', Distance=' , distance printString , ' mi'
          , ', Fare=$'
          , dollars printString , '.'
          , (cents < 10
                ifTrue: [ '0' , cents printString ]
                ifFalse: [ cents printString ])
    ]
]


"---------- StandardRide ----------"
Ride subclass: StandardRide [
    fareCents [
        ^ (200 + (150 * self distance))
    ]

    rideType [ ^ 'StandardRide' ]
]


"---------- PremiumRide ----------"
Ride subclass: PremiumRide [
    fareCents [
        ^ (500 + (300 * self distance))
    ]

    rideType [ ^ 'PremiumRide' ]
]


"---------- Driver ----------"
Object subclass: Driver [
    | driverID name rating assignedRides |

    Driver class >> withID: anID name: aName rating: aRating [
        ^ (self new)
            initializeWithID: anID name: aName rating: aRating;
            yourself
    ]

    initializeWithID: anID name: aName rating: aRating [
        driverID := anID.
        name := aName.
        rating := aRating.
        assignedRides := OrderedCollection new.
    ]

    addRide: aRide [
        assignedRides add: aRide.
    ]

    getDriverInfo [
        ^ 'DriverID=' , driverID printString
          , ', Name=' , name
          , ', Rating=' , rating printString
          , ', CompletedRides=' , assignedRides size printString
    ]

    printCompletedRides [
        stdout nextPutAll: '---- Driver Completed Rides ----'; nl.
        assignedRides do: [ :r |
            stdout nextPutAll: r rideDetails; nl
        ].
    ]
]


"---------- Rider ----------"
Object subclass: Rider [
    | riderID name requestedRides |

    Rider class >> withID: anID name: aName [
        ^ (self new)
            initializeWithID: anID name: aName;
            yourself
    ]

    initializeWithID: anID name: aName [
        riderID := anID.
        name := aName.
        requestedRides := OrderedCollection new.
    ]

    requestRide: aRide [
        requestedRides add: aRide.
    ]

    viewRides [
        stdout nextPutAll: '---- Rider Ride History ----'; nl.
        stdout nextPutAll:
            ('RiderID=' , riderID printString
             , ', Name=' , name
             , ', RequestedRides=' , requestedRides size printString); nl.

        requestedRides do: [ :r |
            stdout nextPutAll: r rideDetails; nl
        ].
    ]
]


"========================
 Demo Script (acts like main)
========================"

| rides r1 r2 rider driver |

rides := OrderedCollection new.

"Use INTEGER distances only"
r1 := StandardRide withID: 101 pickup: 'NJIT' dropoff: 'Newark Penn' distance: 3.
r2 := PremiumRide withID: 202 pickup: 'Jersey City' dropoff: 'Manhattan' distance: 8.

rides add: r1; add: r2.

rider := Rider withID: 1 name: 'Ujjwal'.
rides do: [ :r | rider requestRide: r ].

driver := Driver withID: 10 name: 'Alex' rating: 5.
rides do: [ :r | driver addRide: r ].

stdout nextPutAll: '=== Polymorphic Ride List ==='; nl.
rides do: [ :r | stdout nextPutAll: r rideDetails; nl ].
stdout nl.

stdout nextPutAll: driver getDriverInfo; nl.
driver printCompletedRides.
stdout nl.

rider viewRides.
Transcript show: 'Welcome to SmallTalk online ide from JDoodle.com'."========================
 GNU Smalltalk SAFE VERSION
 No floating point used
========================"

"---------- Ride (Base Class) ----------"
Object subclass: Ride [
    | rideID pickupLocation dropoffLocation distance |

    Ride class >> withID: anID pickup: pick dropoff: drop distance: miles [
        ^ (self new)
            initializeWithID: anID pickup: pick dropoff: drop distance: miles;
            yourself
    ]

    initializeWithID: anID pickup: pick dropoff: drop distance: miles [
        rideID := anID.
        pickupLocation := pick.
        dropoffLocation := drop.
        distance := miles.   "Store distance as integer"
    ]

    rideID [ ^ rideID ]
    distance [ ^ distance ]

    fareCents [
        "Default: base $2 + $1.50 per mile
         Work in cents to avoid float issues"
        ^ (200 + (150 * distance))
    ]

    rideType [ ^ 'Ride' ]

    rideDetails [
        | dollars cents total |

        total := self fareCents.
        dollars := total // 100.
        cents := total \\ 100.

        ^ '[' , self rideType , '] '
          , 'RideID=' , rideID printString
          , ', ' , pickupLocation , ' -> ' , dropoffLocation
          , ', Distance=' , distance printString , ' mi'
          , ', Fare=$'
          , dollars printString , '.'
          , (cents < 10
                ifTrue: [ '0' , cents printString ]
                ifFalse: [ cents printString ])
    ]
]


"---------- StandardRide ----------"
Ride subclass: StandardRide [
    fareCents [
        ^ (200 + (150 * self distance))
    ]

    rideType [ ^ 'StandardRide' ]
]


"---------- PremiumRide ----------"
Ride subclass: PremiumRide [
    fareCents [
        ^ (500 + (300 * self distance))
    ]

    rideType [ ^ 'PremiumRide' ]
]


"---------- Driver ----------"
Object subclass: Driver [
    | driverID name rating assignedRides |

    Driver class >> withID: anID name: aName rating: aRating [
        ^ (self new)
            initializeWithID: anID name: aName rating: aRating;
            yourself
    ]

    initializeWithID: anID name: aName rating: aRating [
        driverID := anID.
        name := aName.
        rating := aRating.
        assignedRides := OrderedCollection new.
    ]

    addRide: aRide [
        assignedRides add: aRide.
    ]

    getDriverInfo [
        ^ 'DriverID=' , driverID printString
          , ', Name=' , name
          , ', Rating=' , rating printString
          , ', CompletedRides=' , assignedRides size printString
    ]

    printCompletedRides [
        stdout nextPutAll: '---- Driver Completed Rides ----'; nl.
        assignedRides do: [ :r |
            stdout nextPutAll: r rideDetails; nl
        ].
    ]
]


"---------- Rider ----------"
Object subclass: Rider [
    | riderID name requestedRides |

    Rider class >> withID: anID name: aName [
        ^ (self new)
            initializeWithID: anID name: aName;
            yourself
    ]

    initializeWithID: anID name: aName [
        riderID := anID.
        name := aName.
        requestedRides := OrderedCollection new.
    ]

    requestRide: aRide [
        requestedRides add: aRide.
    ]

    viewRides [
        stdout nextPutAll: '---- Rider Ride History ----'; nl.
        stdout nextPutAll:
            ('RiderID=' , riderID printString
             , ', Name=' , name
             , ', RequestedRides=' , requestedRides size printString); nl.

        requestedRides do: [ :r |
            stdout nextPutAll: r rideDetails; nl
        ].
    ]
]


"========================
 Demo Script (acts like main)
========================"

| rides r1 r2 rider driver |

rides := OrderedCollection new.

"Use INTEGER distances only"
r1 := StandardRide withID: 101 pickup: 'NJIT' dropoff: 'Newark Penn' distance: 3.
r2 := PremiumRide withID: 202 pickup: 'Jersey City' dropoff: 'Manhattan' distance: 8.

rides add: r1; add: r2.

rider := Rider withID: 1 name: 'Ujjwal'.
rides do: [ :r | rider requestRide: r ].

driver := Driver withID: 10 name: 'Alex' rating: 5.
rides do: [ :r | driver addRide: r ].

stdout nextPutAll: '=== Polymorphic Ride List ==='; nl.
rides do: [ :r | stdout nextPutAll: r rideDetails; nl ].
stdout nl.

stdout nextPutAll: driver getDriverInfo; nl.
driver printCompletedRides.
stdout nl.

rider viewRides.
