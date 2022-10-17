import 'package:crane_master/model/data.dart';
import 'package:crane_master/model/flight.dart';
import 'package:crane_master/theme/color.dart';
import 'package:crane_master/ui/border_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

class _FrontLayer extends StatelessWidget {
  const _FrontLayer({Key key, this.title, this.index}) : super(key: key);

  final String title;
  final int index;
  @override
  Widget build(BuildContext context) {
    return PhysicalShape(
      elevation: 16,
      color: kCranePrimaryWhite,
      clipper: ShapeBorderClipper(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
      ),
      child: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.subtitle1.copyWith(fontSize: 12),
          ),
          SizedBox(height: 12),
          ItemCards(index: index),
        ],
      ),
    );
  }
}

class ItemCards extends StatelessWidget {
  final int index;
  ItemCards({Key key, this.index}) : super(key: key);

  static List<Widget> _buildFlightCards({int listIndex}) {
    final List<Flight> flightsFly = getFlights(Category.findTrips)..shuffle();
    final List<Flight> flightsSleep = getFlights(Category.findTrips)..shuffle();
    final List<Flight> flightsEat = getFlights(Category.findTrips)..shuffle();

    List<Flight> flights;
    switch (listIndex) {
      case 0:
        flights = flightsFly;
        break;
      case 1:
        flights = flightsSleep;
        break;
      case 2:
        flights = flightsEat;
        break;
    }
    return List.generate(flights.length, (int index) {
      return _DestinationCard(flight: flights[index]);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: _buildFlightCards(listIndex: index));
  }
}

class BackDrop extends StatefulWidget {
  final Widget frontLayer;
  final List<Widget> backLayer;
  final Widget frontTitle;
  final Widget backTitle;
  const BackDrop(
      {Key key,
      @required this.frontLayer,
      @required this.backLayer,
      @required this.frontTitle,
      @required this.backTitle})
      : assert(frontLayer != null),
        assert(backLayer != null),
        assert(frontTitle != null),
        assert(backTitle != null);

  @override
  State<BackDrop> createState() => _BackDropState();
}

class _BackDropState extends State<BackDrop> with TickerProviderStateMixin {
  static const List<double> _midHeights = [271, 206, 271];
  static const List<double> _topHeights = [0, 0, 0];
  List<double> _tabHeights = _midHeights;

  TabController _tabController;
  Animation<Offset> _flyLayerOffset;
  Animation<Offset> _sleepLayerOffset;
  Animation<Offset> _eatLayerOffset;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    _flyLayerOffset =
        Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(-1.05, 0.0))
            .animate(_tabController.animation);
    _sleepLayerOffset = Tween<Offset>(
      begin: Offset(1.05, 0.0),
      end: Offset(0, 0.0),
    ).animate(_tabController.animation);

    _eatLayerOffset = Tween<Offset>(
      begin: Offset(2.0, 0.0),
      end: Offset(1.0, 0.0),
    ).animate(_tabController.animation);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabs(int tabIndex) {
    if (_tabController.index == tabIndex) {
      setState(() {
        _tabHeights = _tabHeights == _topHeights ? _midHeights : _topHeights;
      });
    } else {
      _tabController.animateTo(tabIndex, duration: Duration(milliseconds: 300));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          elevation: 0,
          titleSpacing: 0,
          leading: Align(
            child: Transform.translate(
              offset: Offset(-8, -8),
              child: Image.asset('assets/menu.png', height: 20),
            ),
            alignment: Alignment.centerLeft,
          ),
          flexibleSpace: CraneAppBar(
            tabController: _tabController,
            tabHandler: _handleTabs,
          ),
        ),
        body: Stack(
          children: [
            BackLayer(
                tabController: _tabController, backLayers: widget.backLayer),
            AnimatedContainer(
              duration: Duration(milliseconds: 150),
              margin: EdgeInsets.only(top: _tabHeights[0]),
              child: SlideTransition(
                position: _flyLayerOffset,
                child: _FrontLayer(
                  index: 0,
                  title: 'Explore Flights by Destination',
                ),
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 150),
              margin: EdgeInsets.only(top: _tabHeights[1]),
              child: SlideTransition(
                position: _sleepLayerOffset,
                child: _FrontLayer(
                  index: 1,
                  title: 'Explore Properties by Destination',
                ),
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 150),
              margin: EdgeInsets.only(top: _tabHeights[2]),
              child: SlideTransition(
                position: _eatLayerOffset,
                child: _FrontLayer(
                  index: 2,
                  title: 'Explore Restaurants by Destination',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BackLayer extends StatefulWidget {
  final List<Widget> backLayers;
  final TabController tabController;
  BackLayer({Key key, this.backLayers, this.tabController}) : super(key: key);

  @override
  State<BackLayer> createState() => _BackLayerState();
}

class _BackLayerState extends State<BackLayer> {
  @override
  void initState() {
    super.initState();
    widget.tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    widget.tabController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      child: widget.backLayers[widget.tabController.index],
      duration: Duration(milliseconds: 300),
    );
  }
}

class CraneAppBar extends StatefulWidget {
  final Function(int) tabHandler;
  final TabController tabController;
  const CraneAppBar({Key key, this.tabController, this.tabHandler})
      : super(key: key);

  @override
  State<CraneAppBar> createState() => _CraneAppBarState();
}

class _CraneAppBarState extends State<CraneAppBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: IconButton(
              iconSize: 72,
              padding: EdgeInsets.all(0),
              icon: Image.asset(
                'assets/logo.png',
                fit: BoxFit.cover,
              ),
              onPressed: () {},
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width - 72,
            child: TabBar(
              indicator: BorderTabIndicator(indicatorHeight: 32),
              controller: widget.tabController,
              labelPadding: EdgeInsets.all(0),
              tabs: <Widget>[
                _NavigationTab(
                  title: 'FLY',
                  callBack: () => widget.tabHandler(0),
                  tabController: widget.tabController,
                  index: 0,
                ),
                _NavigationTab(
                  title: 'SLEEP',
                  callBack: () => widget.tabHandler(1),
                  tabController: widget.tabController,
                  index: 1,
                ),
                _NavigationTab(
                  title: 'EAT',
                  callBack: () => widget.tabHandler(2),
                  tabController: widget.tabController,
                  index: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NavigationTab extends StatefulWidget {
  final String title;
  final Function callBack;
  final TabController tabController;
  final int index;
  const _NavigationTab(
      {Key key, this.callBack, this.index, this.tabController, this.title})
      : super(key: key);

  @override
  State<_NavigationTab> createState() => __NavigationTabState();
}

class __NavigationTabState extends State<_NavigationTab> {
  @override
  void initState() {
    super.initState();
    widget.tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    widget.tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
        ),
        child: Text(
          widget.title,
          style: Theme.of(context).textTheme.button.copyWith(
                color: widget.tabController.index == widget.index
                    ? kCranePrimaryWhite
                    : kCranePrimaryWhite.withOpacity(.6),
              ),
        ),
        onPressed: widget.callBack,
      ),
    );
  }
}

class _DestinationCard extends StatelessWidget {
  const _DestinationCard({Key key, this.flight}) : super(key: key);
  final Flight flight;
  @override
  Widget build(BuildContext context) {
    final imageWidget = Image.asset(flight.assetName, fit: BoxFit.cover);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          contentPadding: EdgeInsets.only(right: 8),
          leading: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            child: SizedBox(
              height: 60,
              width: 60,
              child: imageWidget,
            ),
          ),
          title: Text(
            flight.destination,
            style: Theme.of(context)
                .textTheme
                .subtitle1
                .copyWith(color: Colors.black),
          ),
          subtitle: Text(
            flight.layover ? 'Layover' : 'NonStop',
            style: Theme.of(context).textTheme.subtitle1.copyWith(fontSize: 12),
          ),
        ),
        SizedBox(
          child: Divider(indent: 4),
        )
      ],
    );
  }
}
