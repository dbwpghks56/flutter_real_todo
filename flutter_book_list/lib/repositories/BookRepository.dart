import '../models/book.dart';

class BookRepository{
  final List<Book> _dumpBooks = [
    Book(
      title: '고양이는 세계 최강이다. 고양이를 국회로.',
      image: 'http://dimg.donga.com/ugc/CDB/WEEKLY/Article/5b/02/77/fa/5b0277fa109dd2738de6.jpg',
      subtitle: '고양이 손은 약손',
      description: '고양이 털은 약털',
    ),
    Book(
      title: '고양이는 세계 제일 귀엽다. 고양이를 전설로',
      image: 'https://post-phinf.pstatic.net/MjAyMDAyMjlfMjY4/MDAxNTgyOTU0Nzg3MjQ4.PBMFV4WrSJmeSUJ56c4C7Vkz_SsQlJ1SByKU18kkJh0g.T7mQnadCWVtEZ448AGk_9kG1HFBAzdztXZcBjvSbduwg.JPEG/%EA%B3%A0%EC%96%91%EC%9D%B4_%EB%82%98%EC%9D%B41.jpg?type=w1200',
      subtitle: '고양이 손은 약손',
      description: '고양이 털은 약털',
    ),
    Book(
      title: '고양이는 멋진놈이니까 세계 정상으로',
      image: 'https://cdn.eyesmag.com/content/uploads/posts/2022/08/08/main-ad65ae47-5a50-456d-a41f-528b63071b7b.jpg',
      subtitle: '고양이 손은 약손',
      description: '고양이 털은 약털',
    ),
    Book(
      title: '고양이는 귀엽다. 근데 세상은 귀엽기만 하면 된다.',
      image: 'https://src.hidoc.co.kr/image/lib/2022/5/4/1651651323632_0.jpg',
      subtitle: '고양이 손은 약손',
      description: '고양이 털은 약털',
    ),
  ];
  List<Book> getBooks() {
    return _dumpBooks;
  }
}