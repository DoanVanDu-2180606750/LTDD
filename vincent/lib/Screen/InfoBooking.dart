class InfoBookingRoom extends StatefulWidget {
  const InfoBookingRoom({super.key});

  @override
  State<InfoBookingRoom> createState() => _InfoBookingRoomState();
}

class _InfoBookingRoomState extends State<InfoBookingRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Room'),
      ),
    );
  }
}