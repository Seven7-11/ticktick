import 'package:flutter/material.dart';

class WalkPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Walk"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTabButton("day", true),
                _buildTabButton("week", false),
                _buildTabButton("month", false),
                _buildTabButton("6 month", false),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Center(
                child: _buildGraph(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          selectedItemColor: Colors.amber,
          unselectedItemColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.nightlight_round), label: ""),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String text, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: isSelected ? Colors.amber : Colors.black,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.black : Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildGraph() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(height: 10),
          const Text(
            "6 /10 km",
            style: TextStyle(color: Colors.amber, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const Text(
            "25 Feb - 4 Mar 2025",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildBar(0.1),
                _buildBar(0.4),
                _buildBar(0.2),
                _buildBar(0.3),
                _buildBar(0.5),
                _buildBar(0.1),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text("6am", style: TextStyle(color: Colors.white)),
              Text("9am", style: TextStyle(color: Colors.white)),
              Text("12pm", style: TextStyle(color: Colors.white)),
              Text("3pm", style: TextStyle(color: Colors.white)),
              Text("6pm", style: TextStyle(color: Colors.white)),
              Text("12am", style: TextStyle(color: Colors.white)),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildBar(double heightFactor) {
    return Container(
      width: 20,
      height: heightFactor * 120,
      decoration: BoxDecoration(
        color: heightFactor > 0.3 ? Colors.amber : Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}