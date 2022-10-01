enum Season { SPRING, SUMMER, AUTUMN, WINTER } # SPRING = 0, SUMMER = 1, AUTUMN = 2, WINTER = 3

class SeasonData:
    var year: int = 0
    var season: int = Season.SPRING
    var season_progress: float = 0
    func tick(delta):
        self.season_progress += delta
        if self.season_progress >= 10:
            self.season_progress -= 10
            self.season = (self.season + 1) % 4
            if self.season == Season.SPRING:
                self.year += 1
                if self.year == 10:
                    pass
                    # TODO
                    # ! trigger endgame event