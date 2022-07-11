import { Component, OnInit } from '@angular/core';
import { AngMusicPlayerModule } from  'ang-music-player';

@Component({
  selector: 'app-dashboard-u',
  templateUrl: './dashboard-u.component.html',
  styleUrls: ['./dashboard-u.component.scss']
})
export class DashboardUComponent implements OnInit {

  constructor() { }

  ngOnInit(): void {
    var audioList = [
      {
        url: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3",
        title: "Smaple 1",
        cover: "https://i1.sndcdn.com/artworks-000249294066-uow7s0-t500x500.jpg"
      },
      {
        url: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-10.mp3",
        title: "Sample 2",
        cover: "https://i1.sndcdn.com/artworks-000249294066-uow7s0-t500x500.jpg"
      },
      {
        url: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-12.mp3",
        title: "Sample 3",
        cover: "https://i1.sndcdn.com/artworks-000249294066-uow7s0-t500x500.jpg"
      }
    ];
  }

}
