import 'package:coding_test/ApiServices/Networking/api_services.dart';
import 'package:coding_test/Utils/box_style.dart';
import 'package:coding_test/Utils/color_utils.dart';
import 'package:coding_test/Utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final StarWarsService _starWarsService = StarWarsService();
  final List<dynamic> _characters = [];
  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasMoreData = true;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    _fetchCharacters();
  }

  Future<void> _fetchCharacters() async {
    if (_isLoading || !_hasMoreData) return;

    setState(() {
      _isLoading = true;
      _isError = false;
    });

    try {
      final data = await _starWarsService.fetchCharacters(_currentPage);

      setState(() {
        _characters.addAll(data['results']);
        _hasMoreData = data['next'] != null;
        _currentPage++;
      });
    } catch (error) {
      setState(() {
        _isError = true;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showCharacterDetails(BuildContext context, dynamic character) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(
              character['name'],
              style: AppTextStyles.title,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Height:', style: AppTextStyles.body),
                  Text('${character['height']} m', style: AppTextStyles.body),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Mass:', style: AppTextStyles.body),
                  Text('${character['mass']} kg', style: AppTextStyles.body),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Birth Year:', style: AppTextStyles.body),
                  Text(character['birth_year'], style: AppTextStyles.body),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Films Appeared In:', style: AppTextStyles.body),
                  Text('${character['films'].length}',
                      style: AppTextStyles.body),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Date Added:', style: AppTextStyles.body),
                  Text(DateFormat('dd-MM-yyyy').format(DateTime.now()),
                      style: AppTextStyles.body),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text(
                'Close',
                style: GoogleFonts.poppins(color: ColorUtils.mainColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: ColorUtils.mainColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Center(
          child: Text(
            'Home Screen',
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
      body: _isError
          ? Center(
              child: Text(
                'Failed to load characters. Please try again.',
                style: AppTextStyles.error,
              ),
            )
          : _buildCharacterList(),
    );
  }

  Widget _buildCharacterList() {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (scrollNotification is ScrollEndNotification &&
            scrollNotification.metrics.extentAfter == 0 &&
            !_isLoading &&
            _hasMoreData) {
          _fetchCharacters();
        }
        return false;
      },
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.9,
          ),
          itemCount: _characters.length + (_hasMoreData ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < _characters.length) {
              final character = _characters[index];
              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: const Duration(milliseconds: 50),
                columnCount: 2,
                child: ScaleAnimation(
                  child: FadeInAnimation(
                    child: InkWell(
                      onTap: () {
                        _showCharacterDetails(context, character);
                      },
                      child: Card(
                        elevation: 2,
                        margin: AppBoxStyles.cardMargin,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: MouseRegion(
                          onEnter: (_) => _onHover(true, index),
                          onExit: (_) => _onHover(false, index),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: AppBoxStyles.cardBoxDecoration(
                                _hoveredIndex == index),
                            child: Padding(
                              padding: AppBoxStyles.cardPadding,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      character['name'],
                                      style: AppTextStyles.title,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Height: ${character['height']} m',
                                    style: AppTextStyles.body,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              // Center the CircularProgressIndicator
              return Center(
                child: CircularProgressIndicator(
                  color: ColorUtils.mainColor,
                ),
              );
            }
          }),
    );
  }

  int _hoveredIndex = -1;

  void _onHover(bool isHovered, int index) {
    setState(() {
      _hoveredIndex = isHovered ? index : -1;
    });
  }
}
