import 'package:movies_app/features/people/models/person.dart';

class DummyPeople {
  static List<Map<String, dynamic>> rawPopularPeople1 = [
    {
      'adult': false,
      'gender': 2,
      'id': 73457,
      'known_for': [
        {
          'adult': false,
          'backdrop_path': '/lmZFxXgJE3vgrciwuDib0N8CfQo.jpg',
          'genre_ids': [12, 28, 878],
          'id': 299536,
          'media_type': 'movie',
          'original_language': 'en',
          'original_title': 'Avengers: Infinity War',
          'overview':
              'As the Avengers and their allies have continued to protect the world from threats too large for any one hero to handle, a new danger has emerged from the cosmic shadows: Thanos. A despot of intergalactic infamy, his goal is to collect all six Infinity Stones, artifacts of unimaginable power, and use them to inflict his twisted will on all of reality. Everything the Avengers have fought for has led up to this moment - the fate of Earth and existence itself has never been more uncertain.',
          'poster_path': '/7WsyChQLEftFiDOVTGkv3hFpyyt.jpg',
          'release_date': '2018-04-25',
          'title': 'Avengers: Infinity War',
          'video': false,
          'vote_average': 8.3,
          'vote_count': 25020
        },
        {
          'adult': false,
          'backdrop_path': '/2UFxrUHVuSK3Tth7DvQQlF4mGTd.jpg',
          'genre_ids': [28, 878, 12],
          'id': 118340,
          'media_type': 'movie',
          'original_language': 'en',
          'original_title': 'Guardians of the Galaxy',
          'overview':
              'Light years from Earth, 26 years after being abducted, Peter Quill finds himself the prime target of a manhunt after discovering an orb wanted by Ronan the Accuser.',
          'poster_path': '/r7vmZjiyZw9rpJMQJdXpjgiCOk9.jpg',
          'release_date': '2014-07-30',
          'title': 'Guardians of the Galaxy',
          'video': false,
          'vote_average': 7.9,
          'vote_count': 24684
        },
        {
          'adult': false,
          'backdrop_path': '/7RyHsO4yDXtBv1zUU3mTpHeQ0d5.jpg',
          'genre_ids': [12, 878, 28],
          'id': 299534,
          'media_type': 'movie',
          'original_language': 'en',
          'original_title': 'Avengers: Endgame',
          'overview':
              "After the devastating events of Avengers: Infinity War, the universe is in ruins due to the efforts of the Mad Titan, Thanos. With the help of remaining allies, the Avengers must assemble once more in order to undo Thanos' actions and restore order to the universe once and for all, no matter what consequences may be in store.",
          'poster_path': '/or06FN3Dka5tukK1e9sl16pB3iy.jpg',
          'release_date': '2019-04-24',
          'title': 'Avengers: Endgame',
          'video': false,
          'vote_average': 8.3,
          'vote_count': 21448
        }
      ],
      'known_for_department': 'Acting',
      'name': 'Chris Pratt',
      'popularity': 118.423,
      'profile_path': '/83o3koL82jt30EJ0rz4Bnzrt2dd.jpg'
    },
    {
      'adult': false,
      'gender': 2,
      'id': 30614,
      'known_for': [
        {
          'adult': false,
          'backdrop_path': '/nyuzfjAbuSel6dVKY4zFo95ugUf.jpg',
          'genre_ids': [35, 18, 10749, 10402],
          'id': 313369,
          'media_type': 'movie',
          'original_language': 'en',
          'original_title': 'La La Land',
          'overview':
              'Mia, an aspiring actress, serves lattes to movie stars in between auditions and Sebastian, a jazz musician, scrapes by playing cocktail party gigs in dingy bars, but as success mounts they are faced with decisions that begin to fray the fragile fabric of their love affair, and the dreams they worked so hard to maintain in each other threaten to rip them apart.',
          'poster_path': '/uDO8zWDhfWwoFdKS4fzkUJt0Rf0.jpg',
          'release_date': '2016-11-29',
          'title': 'La La Land',
          'video': false,
          'vote_average': 7.9,
          'vote_count': 14402
        },
        {
          'adult': false,
          'backdrop_path': '/sAtoMqDVhNDQBc3QJL3RF6hlhGq.jpg',
          'genre_ids': [878, 18],
          'id': 335984,
          'media_type': 'movie',
          'original_language': 'en',
          'original_title': 'Blade Runner 2049',
          'overview':
              "Thirty years after the events of the first film, a new blade runner, LAPD Officer K, unearths a long-buried secret that has the potential to plunge what's left of society into chaos. K's discovery leads him on a quest to find Rick Deckard, a former LAPD blade runner who has been missing for 30 years.",
          'poster_path': '/gajva2L0rPYkEWjzgFlBXCAVBE5.jpg',
          'release_date': '2017-10-04',
          'title': 'Blade Runner 2049',
          'video': false,
          'vote_average': 7.5,
          'vote_count': 10895
        },
        {
          'adult': false,
          'backdrop_path': '/9ly9pxGwiB6g5lIZXou2HKXl7ua.jpg',
          'genre_ids': [18, 53, 80],
          'id': 64690,
          'media_type': 'movie',
          'original_language': 'en',
          'original_title': 'Drive',
          'overview':
              "Driver is a skilled Hollywood stuntman who moonlights as a getaway driver for criminals. Though he projects an icy exterior, lately he's been warming up to a pretty neighbor named Irene and her young son, Benicio. When Irene's husband gets out of jail, he enlists Driver's help in a million-dollar heist. The job goes horribly wrong, and Driver must risk his life to protect Irene and Benicio from the vengeful masterminds behind the robbery.",
          'poster_path': '/602vevIURmpDfzbnv5Ubi6wIkQm.jpg',
          'release_date': '2011-09-15',
          'title': 'Drive',
          'video': false,
          'vote_average': 7.6,
          'vote_count': 10528
        }
      ],
      'known_for_department': 'Acting',
      'name': 'Ryan Gosling',
      'popularity': 112.505,
      'profile_path': '/lyUyVARQKhGxaxy0FbPJCQRpiaW.jpg'
    },
  ];

  static List<Person> popularPeople =
      List<Person>.from(rawPopularPeople1.map((x) => Person.fromJson(x)));
}