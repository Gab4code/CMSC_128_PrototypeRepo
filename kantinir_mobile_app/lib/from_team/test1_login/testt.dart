class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Person Image
            Image.asset('images/person1.png', width: 280, height: 280),

            const SizedBox(height: 20),

            // "Let's get you in!" Text
            const Text(
              "Let's get you in!",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // Email Box with Icon
            Container(
              width: 300,
              height: 28,
              decoration: BoxDecoration(
                color: Color(0xFFD9D9D9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Icon(Icons.email, color: Color(0xFFB6B6B6)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Email',
                          style: TextStyle(
                            color: Color(0xFFB6B6B6),
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Password Box with Icon
            Container(
              width: 300,
              height: 28,
              decoration: BoxDecoration(
                color: Color(0xFFD9D9D9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Icon(Icons.lock, color: Color(0xFFB6B6B6)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Password',
                          style: TextStyle(
                            color: Color(0xFFB6B6B6),
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // "Sign In" Button
            SizedBox(
              width: 300,
              height: 34,
              child: ElevatedButton(
                onPressed: () {
                  // Add action when the "Sign In" button is clicked
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF11CDA7), // Set the button color to #11CDA7
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10.0), // Make the button rounded
                  ),
                ),
                child: const Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // "Don't have an account? Sign up" Text
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SignUp(),
                ));
              },
              child: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: 'Sign up',
                      style: TextStyle(
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Padding(
  padding: EdgeInsets.only(left: 31), // Add 31 pixels of padding from the left
  child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
          const Text(
            "Create your",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            "account",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Email Box with Icon
          // ... (Same code as in SignIn for Email)

          const SizedBox(height: 10),

          // Password Box with Icon
          // ... (Same code as in SignIn for Password)

          const SizedBox(height: 10),

          // Confirm Password Box with Icon
          Container(
            width: 300,
            height: 28,
            decoration: BoxDecoration(
              color: Color(0xFFD9D9D9),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Icon(Icons.email, color: Color(0xFFB6B6B6)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Email',
                        style: TextStyle(
                          color: Color(0xFFB6B6B6),
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Sign Up Box
          Container(
            width: 300,
            height: 28,
            decoration: BoxDecoration(
              color: Color(0xFFD9D9D9),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Icon(Icons.lock, color: Color(0xFFB6B6B6)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Password',
                        style: TextStyle(
                          color: Color(0xFFB6B6B6),
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: 300,
            height: 28,
            decoration: BoxDecoration(
              color: Color(0xFFD9D9D9),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Icon(Icons.lock, color: Color(0xFFB6B6B6)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Confirm Password',
                        style: TextStyle(
                          color: Color(0xFFB6B6B6),
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 300,
            height: 34,
            child: ElevatedButton(
              onPressed: () {
                // Add action when the "Sign In" button is clicked
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF11CDA7), // Set the button color to #11CDA7
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10.0), // Make the button rounded
                ),
              ),
              child: const Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
    ],
  ),
),


Padding(
            padding: const EdgeInsets.only(
              top: 31.0,
            ), // Add 31 pixels of padding from the top
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                size: 40,
                color: Color(0xFF22A1BB),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),

          class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Back Arrow with padding
          Padding(
            padding: const EdgeInsets.only(
              top: 31.0,
            ), // Add 31 pixels of padding from the top
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                size: 40,
                color: Color(0xFF22A1BB),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),

          const SizedBox(height: 80),
          Padding(
            padding: const EdgeInsets.only(
                left: 31), // Add 31 pixels of padding from the left
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Text(
                  "Create your",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "account",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Email Box with Icon
                // ... (Same code as in SignIn for Email)

                const SizedBox(height: 10),

                // Password Box with Icon
                // ... (Same code as in SignIn for Password)

                const SizedBox(height: 10),

                // Confirm Password Box with Icon
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    prefixIcon: Icon(Icons.email, color: Color(0xFFB6B6B6)),
                    filled: true,
                    fillColor: Color(0xFFD9D9D9),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFFB6B6B6),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),

                SizedBox(height: 10),

                TextField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    prefixIcon: Icon(Icons.lock, color: Color(0xFFB6B6B6)),
                    filled: true,
                    fillColor: Color(0xFFD9D9D9),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFFB6B6B6),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),

                SizedBox(height: 10),

                TextField(
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    hintText: 'Confirm your password',
                    prefixIcon: Icon(Icons.lock, color: Color(0xFFB6B6B6)),
                    filled: true,
                    fillColor: Color(0xFFD9D9D9),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFFB6B6B6),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),

                SizedBox(height: 10),

                SizedBox(
                  width: 300,
                  height: 34,
                  child: ElevatedButton(
                    onPressed: () {
                      // Add action when the "Sign In" button is clicked
                    },
                    style: ElevatedButton.styleFrom(
                      primary:
                          Color(0xFF11CDA7), // Set the button color to #11CDA7
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Make the button rounded
                      ),
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}