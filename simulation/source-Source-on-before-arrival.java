// Maximum number of arrivals : 값 지정
if (!boxCollection.isEmpty()) {
Box box = boxCollection.remove(0);
        queue.onEnter(box);
        System.out.println(box.id+" "+box.width);
}